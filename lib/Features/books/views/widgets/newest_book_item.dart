import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/app_router.dart';
import 'package:novella/Features/books/data/models/book_model/book_model.dart';
import 'package:novella/Features/books/views/widgets/rating_widget.dart';

class BestSellerItem extends StatelessWidget {
  final BookModel bookModel;

  const BestSellerItem({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: bookModel);
      },
      child: AspectRatio(
        aspectRatio: 4 / 1.5, // Responsive proportion
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset.zero,
              ),
            ],
          ),

          child: Row(
            children: [
              // Book Cover
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CachedNetworkImage(
                    imageUrl: bookModel.volumeInfo.imageLinks?.thumbnail ?? '',
                    fit: BoxFit.fill,
                    fadeInDuration: Duration(milliseconds: 100),
                    errorWidget:
                        (context, url, error) => const Icon(
                          FontAwesomeIcons.exclamation,
                          color: Colors.red,
                        ),
                  ),
                ),
              ),

              SizedBox(width: 14),

              // Book Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        bookModel.volumeInfo.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      // Author
                      Text(
                        bookModel.volumeInfo.authors?[0] ?? '',
                        style: TextStyle(
                          fontSize: width * 0.040,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            'Free',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Rate
                          RatingWidget(
                            averageRating: bookModel.volumeInfo.averageRating,
                            ratingsCount: bookModel.volumeInfo.ratingsCount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
