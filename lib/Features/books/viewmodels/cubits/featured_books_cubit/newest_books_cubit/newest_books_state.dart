import 'package:novella/Features/books/data/models/book_model/book_model.dart';

abstract class NewestBooksState {
  const NewestBooksState();
}

class NewestBooksInitital extends NewestBooksState {}

class NewestBooksLoading extends NewestBooksState {}

class NewestBooksFailure extends NewestBooksState {
  final String errorMessage;
  const NewestBooksFailure(this.errorMessage);
}

class NewestBooksSuccess extends NewestBooksState {
  final List<BookModel> books;
  const NewestBooksSuccess(this.books);
}
