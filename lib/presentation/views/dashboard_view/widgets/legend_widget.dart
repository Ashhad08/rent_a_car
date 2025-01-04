import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';

class LegendWidget extends StatelessWidget {
  final String title;

  const LegendWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 119),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.outline.withOp(0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 5, backgroundColor: context.colorScheme.primary),
          6.width,
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
