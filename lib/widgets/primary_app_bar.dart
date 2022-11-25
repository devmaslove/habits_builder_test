import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _heightAppBar = 84.0;

  final bool showBack;
  final String title;

  const PrimaryAppBar({
    super.key,
    required this.title,
    required this.showBack,
  }) : preferredSize = const Size.fromHeight(_heightAppBar);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: _heightAppBar,
      title: SizedBox(
        height: _heightAppBar,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBack)
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  splashRadius: 22,
                  padding: EdgeInsets.zero,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                  ),
                ),
              ),
            if (showBack) const SizedBox(width: 20),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 32 / 18,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showBack) const SizedBox(width: 64),
          ],
        ),
      ),
    );
  }
}
