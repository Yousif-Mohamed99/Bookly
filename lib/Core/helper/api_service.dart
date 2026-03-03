import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  ApiService(this.dio);
  final Dio dio;
  final String base_url = 'https://www.googleapis.com/books/v1/';
  final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];
  final Map<String, Map<String, dynamic>> _cache = {};

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    // Return cached data if available
    if (_cache.containsKey(endPoint)) {
      return _cache[endPoint]!;
    }

    final response = await dio.get(
      '$base_url$endPoint',
      queryParameters: {'key': apiKey},
    );

    // Cache the response
    _cache[endPoint] = response.data;

    return response.data;
  }
}
