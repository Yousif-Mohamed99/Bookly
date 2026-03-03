import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novella/Core/utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Logo.png"),
            SizedBox(height: 30),
            AnimatedBuilder(
              animation: slidingAnimation,
              builder: (context, _) {
                return SlideTransition(
                  position: slidingAnimation,
                  child: Text(
                    "Read Your Favourite Books",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: Offset(0, 5),
      end: Offset(0, 0),
    ).animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      GoRouter.of(context).push(AppRouter.kHomeView);
    });
  }
}
