import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/app_router.dart';
import 'package:novella/Features/books/data/models/book_model/book_model.dart';
import 'package:novella/Features/books/views/widgets/book_button_action.dart';
import 'package:novella/Features/books/views/widgets/similar_books_section.dart';
import 'package:novella/Features/books/views/widgets/custom_book_item.dart';
import 'package:novella/Features/books/views/widgets/rating_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsBody extends StatelessWidget {
  const BookDetailsBody({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.17),
                  child: CustomBookItem(
                    imageUrl: bookModel.volumeInfo.imageLinks?.thumbnail ?? '',
                  ),
                ),
                SizedBox(height: 30),
                // Book Details
                Text(
                  bookModel.volumeInfo.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  bookModel.volumeInfo.authors?[0] ?? '0',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                SizedBox(height: 15),
                RatingWidget(
                  averageRating: bookModel.volumeInfo.averageRating,
                  ratingsCount: bookModel.volumeInfo.ratingsCount,
                ),
                SizedBox(height: 30),
                // Book Buttons
                Row(
                  children: [
                    Expanded(
                      child: BookButtonAction(
                        buttonText: 'Free',
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BookButtonAction(
                        onTab: () async {
                          final Uri url = Uri.parse(
                            bookModel.volumeInfo.previewLink!,
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        buttonText: 'Free Preview',
                        textColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                          255,
                          225,
                          108,
                          73,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: const SizedBox(height: 50)),
                SimilarBooksSection(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop(AppRouter.kHomeView);
            },
            icon: Icon(Icons.close),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.add_card_sharp)),
        ],
      ),
    );
  }
}
