import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/app_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Image.asset('assets/images/Logo.png', width: 100),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchView);
          },
          icon: Icon(FontAwesomeIcons.magnifyingGlass),
        ),
      ],
    );
  }
}

