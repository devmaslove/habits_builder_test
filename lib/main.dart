import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/screens/forgot_password_screen.dart';
import 'package:habits_builder_test/screens/introduction_screen.dart';
import 'package:habits_builder_test/screens/new_habit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bg,
          foregroundColor: AppColors.primary,
          elevation: 0,
        ),
        fontFamily: 'Manrope',
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: NavigateButtons(),
        ),
      ),
    );
  }
}

enum ScreenButtons {
  intro(
    title: 'Intro',
    screen: IntroductionScreen(),
  ),
  forgotPassword(
    title: 'Forgot Password',
    screen: ForgotPasswordScreen(),
  ),
  newHabit(
    title: 'New Habit',
    screen: NewHabitScreen(),
  );

  const ScreenButtons({
    required this.title,
    required this.screen,
  });

  final String title;
  final Widget screen;
}

class NavigateButtons extends StatelessWidget {
  const NavigateButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Wrap(
        direction: Axis.vertical,
        spacing: 20,
        children: ScreenButtons.values.map((button) {
          return SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => button.screen,
                  ),
                );
              },
              child: Text(button.title),
            ),
          );
        }).toList(),
      ),
    );
  }
}
