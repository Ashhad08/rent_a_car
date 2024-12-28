import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height,
      this.width});

  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF406DB5),
              Color(0xFF2C446A),
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height ?? 54,
            minWidth: width ?? double.infinity,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
