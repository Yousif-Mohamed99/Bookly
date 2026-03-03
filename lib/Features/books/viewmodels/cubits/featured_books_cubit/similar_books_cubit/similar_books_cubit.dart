import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/similar_books_cubit/similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepo) : super(SimilarBooksInitital());

  final HomeRepo homeRepo;

  Future<void> fetchSimilarBooks({required String category}) async {
    emit(SimilarBooksLoading());

    final result = await homeRepo.fetchSimilarBooks(category: category);

    result.fold(
      (failure) {
        emit(SimilarBooksFailure(failure.errorMessage));
      },
      (books) {
        emit(SimilarBooksSuccess(books));
      },
    );
  }
}
