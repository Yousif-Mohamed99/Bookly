import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitital());

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    final result = await homeRepo.fetchFeaturedBooks();

    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errorMessage));
      },
      (books) {
        emit(FeaturedBooksSuccess(books));
      },
    );
  }
}
