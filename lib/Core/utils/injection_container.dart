import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:novella/Core/helper/api_service.dart';
import 'package:novella/Features/books/data/models/repo/home_repo_impl.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<ApiService>(ApiService(Dio()));
  sl.registerSingleton<HomeRepoImpl>(HomeRepoImpl(sl.get<ApiService>()));
  sl.registerSingleton<HomeRepo>(sl.get<HomeRepoImpl>());
}
