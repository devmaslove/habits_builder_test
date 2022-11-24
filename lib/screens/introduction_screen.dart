import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/resources/app_styles.dart';
import 'package:habits_builder_test/widgets/primary_button.dart';
import 'package:wstore/wstore.dart';

enum IntroductionPages {
  welcome(
    title: 'Welcome to Monumental habits',
    asset: 'assets/images/Illustration1.png',
  ),
  create(
    title: 'Create new habit easily',
    asset: 'assets/images/Illustration2.png',
  ),
  progress(
    title: 'Keep track of your progress',
    asset: 'assets/images/Illustration3.png',
  ),
  community(
    title: 'Join a supportive community',
    asset: 'assets/images/Illustration4.png',
  );

  const IntroductionPages({
    required this.title,
    required this.asset,
  });

  final String title;
  final String asset;
}

class IntroductionScreenStore extends WStore {
  PageController controller = PageController();
  int currentPage = 0;

  void setCurrentPage(int index) {
    setStore(() => currentPage = index);
  }

  @override
  IntroductionScreen get widget => super.widget as IntroductionScreen;

  static IntroductionScreenStore of(BuildContext context) {
    return WStoreWidget.store<IntroductionScreenStore>(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        const SizedBox(height: 80),
        Expanded(
          child: PageView(
            controller: store.controller,
            onPageChanged: (index) => store.setCurrentPage(index),
            children: IntroductionPages.values
                .map(
                  (page) => IntroductionPage(
                    title: page.title,
                    asset: page.asset,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: WStoreValueBuilder<IntroductionScreenStore, int>(
            watch: (store) => store.currentPage,
            builder: (context, currentPage) {
              if (currentPage == IntroductionPages.values.length - 1) {
                return PrimaryButton(
                  text: 'Get Started',
                  onPressed: () => Navigator.maybePop(context),
                );
              }
              return SizedBox(
                height: 60,
                child: DotsPanel(
                  onSkip: () => Navigator.maybePop(context),
                  onNext: () {
                    store.controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  currentPage: currentPage,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class DotsPanel extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final int currentPage;

  const DotsPanel({
    super.key,
    required this.onSkip,
    required this.onNext,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IndicatorButton(
          text: 'Skip',
          onPressed: onSkip,
        ),
        Expanded(
          child: Center(
            child: IndicatorDots(
              count: IntroductionPages.values.length,
              current: currentPage,
            ),
          ),
        ),
        IndicatorButton(
          text: 'Next',
          onPressed: onNext,
        ),
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
    final double height = selected ? 13 : 11;
    final double width = selected ? 13 : 11;
    final color = selected ? AppColors.primary : AppColors.secondary;
    final border = selected
        ? Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 2,
            strokeAlign: StrokeAlign.outside,
          )
        : null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: border,
        shape: BoxShape.circle,
      ),
    );
  }
}

class IndicatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const IndicatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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

class IntroductionPage extends StatelessWidget {
  final String title;
  final String asset;

  const IntroductionPage({
    super.key,
    required this.title,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
