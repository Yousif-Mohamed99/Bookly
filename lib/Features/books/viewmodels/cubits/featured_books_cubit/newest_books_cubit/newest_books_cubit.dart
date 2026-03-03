import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/newest_books_cubit/newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitital());

  final HomeRepo homeRepo;

  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoading());
    final result = await homeRepo.fetchNewestBooks();

    result.fold(
      (failure) {
        emit(NewestBooksFailure(failure.errorMessage));
      },
      (books) {
        emit(NewestBooksSuccess(books));
      },
    );
  }
}
