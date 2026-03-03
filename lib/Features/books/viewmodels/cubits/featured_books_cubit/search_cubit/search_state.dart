import 'package:novella/Features/books/data/models/book_model/book_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<BookModel> books;
  const SearchSuccess(this.books);
}

class SearchFailure extends SearchState {
  final String errorMessage;
  const SearchFailure(this.errorMessage);
}

class SearchButtonDisabled extends SearchState {
  const SearchButtonDisabled();
}
