import 'package:novella/Features/books/data/models/book_model/book_model.dart';

abstract class FeaturedBooksState {
  const FeaturedBooksState();
}

class FeaturedBooksInitital extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String errorMessage;
  const FeaturedBooksFailure(this.errorMessage);
}

class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookModel> books;
  const FeaturedBooksSuccess(this.books);
}
