import 'package:novella/Features/books/data/models/book_model/book_model.dart';

abstract class SimilarBooksState {
  const SimilarBooksState();
}

class SimilarBooksInitital extends SimilarBooksState {}

class SimilarBooksLoading extends SimilarBooksState {}

class SimilarBooksFailure extends SimilarBooksState {
  final String errorMessage;
  const SimilarBooksFailure(this.errorMessage);
}

class SimilarBooksSuccess extends SimilarBooksState {
  final List<BookModel> books;
  const SimilarBooksSuccess(this.books);
}
