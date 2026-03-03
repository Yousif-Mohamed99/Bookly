import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/injection_container.dart';
import 'package:novella/Features/books/data/models/book_model/book_model.dart';
import 'package:novella/Features/books/data/models/repo/home_repo.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/similar_books_cubit/similar_books_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/search_cubit/search_cubit.dart';
import 'package:novella/Features/books/views/book_details_view.dart';
import 'package:novella/Features/books/views/home_view.dart';
import 'package:novella/Features/books/views/splash_view.dart';
import 'package:novella/Features/books/views/search_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (BuildContext context, GoRouterState state) {
          return HomeView();
        },
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SimilarBooksCubit(sl.get<HomeRepo>()),
            child: BookDetailsView(bookModel: state.extra as BookModel),
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SearchCubit(sl.get<HomeRepo>()),
            child: const SearchView(),
          );
        },
      ),
    ],
  );
}

