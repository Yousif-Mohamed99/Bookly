import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBookItem extends StatelessWidget {
  const CustomBookItem({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3, // Book ratio
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            fadeInDuration: Duration(milliseconds: 100),
            errorWidget:
                (context, url, error) =>
                    const Icon(FontAwesomeIcons.exclamation, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
