import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 6,
          color: AppColors.secondary2.withOpacity(0.2),
          strokeAlign: StrokeAlign.outside,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        shape: const CircleBorder(),
        color: AppColors.secondary2,
        clipBehavior: Clip.antiAlias,
        elevation: 16.0,
        child: IconButton(
          padding: const EdgeInsets.all(16),
          onPressed: onPressed,
          iconSize: 20,
          icon: icon,
        ),
      ),
    );
  }
}
