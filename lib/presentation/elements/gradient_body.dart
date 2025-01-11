import 'package:flutter/material.dart';

class GradientBody extends StatelessWidget {
  const GradientBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF66826F),
            Color(0xFF161C18),
          ],
          stops: [0.0, 0.4],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
