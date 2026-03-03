import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:novella/Core/utils/app_router.dart';
import 'package:novella/Core/utils/injection_container.dart';
import 'package:novella/Features/books/data/models/repo/home_repo_impl.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/featured_books_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/newest_books_cubit/newest_books_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/similar_books_cubit/similar_books_cubit.dart';
import 'package:novella/constants.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(sl.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(sl.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => SimilarBooksCubit(sl.get<HomeRepoImpl>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
        ),
        title: 'Bookly',
      ),
    );
  }
}
