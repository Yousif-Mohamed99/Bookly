import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/newest_books_cubit/newest_books_cubit.dart';
import 'package:novella/Features/books/viewmodels/cubits/featured_books_cubit/newest_books_cubit/newest_books_state.dart';
import 'package:novella/Features/books/views/widgets/newest_book_item.dart';

class BestSellerListView extends StatefulWidget {
  const BestSellerListView({super.key});

  @override
  State<BestSellerListView> createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends State<BestSellerListView> {
  @override
  void initState() {
    super.initState();
    // Fetch books when widget is first built
    context.read<NewestBooksCubit>().fetchNewestBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BestSellerItem(bookModel: state.books[index]),
              );
            },
          );
        } else if (state is NewestBooksFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        // NewestBooksLoading
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
