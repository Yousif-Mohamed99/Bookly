import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:novella/Core/helper/api_service.dart';
import 'package:novella/Core/utils/errors/failures.dart';
import 'package:novella/Features/books/data/models/book_model/book_model.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this.apiService);
  final ApiService apiService;

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
        endPoint: "volumes?Filtering=free-ebooks&q=comedy",
      );

      List<BookModel> books = [];

      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(
        endPoint: "volumes?Filtering=free-ebooks&q=comic",
      );

      List<BookModel> books = [];

      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({
    required String category,
  }) async {
    try {
      var data = await apiService.get(
        endPoint: "volumes?Filtering=free-ebooks&Sorting=relevance&q=comic",
      );

      List<BookModel> books = [];

      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> searchBooks({
    required String query,
  }) async {
    try {
      var data = await apiService.get(
        endPoint: "volumes?Filtering=free-ebooks&q=$query",
      );

      List<BookModel> books = [];

      for (var item in data['items'] ?? []) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
