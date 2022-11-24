import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_styles.dart';
import 'package:wstore/wstore.dart';

class SplashScreenStore extends WStore {
  bool showNextScreen = false;

  startTimerNextPage() {
    setTimer(
      duration: const Duration(seconds: 2),
      onTimer: () => setStore(() {
        showNextScreen = true;
      }),
    );
  }

  @override
  SplashScreen get widget => super.widget as SplashScreen;

  static SplashScreenStore of(BuildContext context) {
    return WStoreWidget.store<SplashScreenStore>(context);
  }
}

class SplashScreen extends WStoreWidget<SplashScreenStore> {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  SplashScreenStore createWStore() => SplashScreenStore()..startTimerNextPage();

  @override
  Widget build(BuildContext context, SplashScreenStore store) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SplashScreenContent(),
          ),
        ),
      ],
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WStoreBoolListener<SplashScreenStore>(
      watch: (store) => store.showNextScreen,
      onTrue: (context) => Navigator.maybePop(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 96, left: 32, right: 32),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Welcome to Monumental habits'.toUpperCase(),
            style: AppStyles.title.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
