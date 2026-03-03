import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/app_router.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/featured_books_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/featured_books_state.dart';
import 'package:novella/Features/books/views/widgets/custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({super.key});

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  @override
  void initState() {
    super.initState();
    // Fetch books when widget is first built
    context.read<FeaturedBooksCubit>().fetchFeaturedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.kBookDetailsView,
                        extra: state.books[index],
                      );
                    },
                    child: CustomBookItem(
                      imageUrl:
                          state.books[index].volumeInfo.imageLinks?.thumbnail ??
                          '',
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is FeaturedBooksFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        // FeaturedBooksLoading
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
