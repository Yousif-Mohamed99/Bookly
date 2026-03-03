import 'package:dio/dio.dart';

abstract class Failure {
  Failure(this.errorMessage);
  final String errorMessage;
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          "Connection timed out. Please check your internet connection.",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          "Request timed out while sending data. Try again.",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Response timed out. Please try again later.");
      case DioExceptionType.badCertificate:
        return ServerFailure(
          "Bad SSL certificate. Unable to establish a secure connection.",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure("Request was cancelled.");
      case DioExceptionType.connectionError:
        return ServerFailure(
          "Failed to connect to the server. Please check your network.",
        );
      case DioExceptionType.unknown:
        return ServerFailure("An unexpected error occurred. Please try again.");
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 429) {
      return ServerFailure(
        "Too many requests. Please wait a moment and try again.",
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        response?['error']['message'] ?? "Unauthorized request.",
      );
    } else if (statusCode == 404) {
      return ServerFailure("Requested resource not found.");
    } else if (statusCode == 500) {
      return ServerFailure("Internal server error. Please try again later.");
    } else {
      return ServerFailure("Oops! Something went wrong. Please try again.");
    }
  }
}
