import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../domain/services/session_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../auth/login_view/login_view.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final isLoggedIn = await SessionManager().isLoggedIn();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    if (isLoggedIn) {
      getIt<NavigationHelper>().pushReplacement(context, const BottomNavBar());
    } else {
      getIt<NavigationHelper>().pushReplacement(context, const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onSecondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(Assets.imagesAppLogo),
        ),
      ),
    );
  }
}
