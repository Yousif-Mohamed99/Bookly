import 'package:dartz/dartz.dart';
import 'package:novella/Core/utils/errors/failures.dart';
import 'package:novella/Features/books/data/models/book_model/book_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks();
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({
    required String category,
  });
  Future<Either<Failure, List<BookModel>>> searchBooks({
    required String query,
  });
}
