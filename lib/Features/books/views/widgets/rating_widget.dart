import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingWidget extends StatelessWidget {
  final num? averageRating;
  final int? ratingsCount;

  const RatingWidget({
    super.key,
    required this.averageRating,
    required this.ratingsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 18),
        SizedBox(width: 6),
        Text(
          averageRating?.toString() ?? '0',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 6),
        Text(
          '(${ratingsCount?.toString() ?? '0'})',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
