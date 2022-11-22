import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/resources/app_styles.dart';
import 'package:wstore/wstore.dart';

class IntroductionScreenStore extends WStore {
  static const pagesCount = 4;
  int currentPage = 0;

  @override
  IntroductionScreen get widget => super.widget as IntroductionScreen;

  static IntroductionScreenStore of(BuildContext context) {
    return WStoreWidget.store<IntroductionScreenStore>(context);
  }
}

class IntroductionScreen extends WStoreWidget<IntroductionScreenStore> {
  const IntroductionScreen({super.key});

  @override
  IntroductionScreenStore createWStore() => IntroductionScreenStore();

  @override
  Widget build(BuildContext context, IntroductionScreenStore store) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IntroductionScreenContent(),
      ),
    );
  }
}

class IntroductionScreenContent extends StatelessWidget {
  const IntroductionScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final store = IntroductionScreenStore.of(context);
    return Column(
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (index) =>
                store.setStore(() => store.currentPage = index),
            children: const [
              IndroductionPage(
                title: 'Welcome to Monumental habits',
                asset: 'assets/images/Illustration1.png',
              ),
              IndroductionPage(
                title: 'Create new habit easily',
                asset: 'assets/images/Illustration2.png',
              ),
              IndroductionPage(
                title: 'Keep track of your progress',
                asset: 'assets/images/Illustration3.png',
              ),
              IndroductionPage(
                title: 'Join a supportive community',
                asset: 'assets/images/Illustration4.png',
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        Row(
          children: [
            const SizedBox(width: 24),
            const IndicatorButton(text: 'Skip'),
            Expanded(
              child: Center(
                child: WStoreValueBuilder<IntroductionScreenStore, int>(
                  watch: (store) => store.currentPage,
                  builder: (context, page) {
                    return IndicatorDots(
                      count: IntroductionScreenStore.pagesCount,
                      current: page,
                    );
                  },
                ),
              ),
            ),
            const IndicatorButton(text: 'Next'),
            const SizedBox(width: 24),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class IndicatorDots extends StatelessWidget {
  final int count;
  final int current;

  const IndicatorDots({
    super.key,
    required this.count,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < count; i++) IndicatorDot(selected: i == current),
      ],
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool selected;

  const IndicatorDot({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: selected ? 13 : 11,
      width: selected ? 13 : 11,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.secondary,
        border: selected
            ? Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 2,
                strokeAlign: StrokeAlign.outside,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class IndicatorButton extends StatelessWidget {
  final String text;

  const IndicatorButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 17,
        ),
      ),
    );
  }
}

class IndroductionPage extends StatelessWidget {
  final String title;
  final String asset;

  const IndroductionPage({
    super.key,
    required this.title,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            title.toUpperCase(),
            style: AppStyles.title.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              asset,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text.rich(
            TextSpan(
              text: 'We can '.toUpperCase(),
              children: [
                TextSpan(
                  text: 'help you '.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.secondary2,
                  ),
                ),
                TextSpan(
                  text: 'to be a better version of '.toUpperCase(),
                ),
                TextSpan(
                  text: 'yourself.'.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.secondary2,
                  ),
                ),
              ],
            ),
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 17,
              height: 1.41,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
