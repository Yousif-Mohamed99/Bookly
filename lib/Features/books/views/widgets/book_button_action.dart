import 'package:flutter/material.dart';

class BookButtonAction extends StatelessWidget {
  const BookButtonAction({
    super.key,
    required this.buttonText,
    required this.textColor,
    required this.borderRadius,
    required this.backgroundColor,
    this.onTab,
  });
  final String buttonText;
  final Color textColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final void Function()? onTab;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          backgroundColor: backgroundColor,
        ),
        onPressed: onTab,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
