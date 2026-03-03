import 'package:flutter/material.dart';
import 'package:novella/Features/books/views/widgets/newest_books_list_view.dart';
import 'package:novella/Features/books/views/widgets/featured_books_list_view.dart';
import 'package:novella/Features/books/views/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  FeaturedBooksListView(),
                  SizedBox(height: 55),
                  Text(
                    "Newest Books",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),

          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: BestSellerListView(),
            ),
          ),
        ],
      ),
    );
  }
}
