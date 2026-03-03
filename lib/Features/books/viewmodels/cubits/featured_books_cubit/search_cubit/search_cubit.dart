import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.homeRepo) : super(SearchInitial());

  final HomeRepo homeRepo;
  Timer? _debounceTimer;
  Timer? _buttonDisableTimer;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    // Start new debounce timer (500ms delay)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchLoading());
      final result = await homeRepo.searchBooks(query: query);

      result.fold(
        (failure) {
          emit(SearchFailure(failure.errorMessage));
        },
        (books) {
          emit(SearchSuccess(books));
        },
      );
    });
  }

  Future<void> submitSearch(String query) async {
    if (query.isEmpty) return;

    // Cancel debounce timer if still running
    _debounceTimer?.cancel();

    emit(SearchLoading());
    final result = await homeRepo.searchBooks(query: query);

    result.fold(
      (failure) {
        emit(SearchFailure(failure.errorMessage));
        // Re-enable button after 2 seconds on error
        _startButtonDisableTimer();
      },
      (books) {
        emit(SearchSuccess(books));
        // Disable button for 2 seconds after successful search
        _startButtonDisableTimer();
      },
    );
  }

  void _startButtonDisableTimer() {
    _buttonDisableTimer?.cancel();
    _buttonDisableTimer = Timer(const Duration(seconds: 2), () {
      // Re-emit current success/failure state to re-enable button
      if (state is SearchSuccess) {
        final currentBooks = (state as SearchSuccess).books;
        emit(SearchSuccess(currentBooks));
      } else if (state is SearchFailure) {
        final errorMsg = (state as SearchFailure).errorMessage;
        emit(SearchFailure(errorMsg));
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _buttonDisableTimer?.cancel();
    return super.close();
  }
}
