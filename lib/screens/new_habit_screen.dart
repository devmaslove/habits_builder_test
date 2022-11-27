import 'package:flutter/material.dart';
import 'package:habits_builder_test/widgets/primary_action_button.dart';
import 'package:habits_builder_test/widgets/primary_app_bar.dart';
import 'package:wstore/wstore.dart';

class NewHabitScreenStore extends WStore {
  @override
  NewHabitScreen get widget => super.widget as NewHabitScreen;

  static NewHabitScreenStore of(BuildContext context) {
    return WStoreWidget.store<NewHabitScreenStore>(context);
  }
}

class NewHabitScreen extends WStoreWidget<NewHabitScreenStore> {
  const NewHabitScreen({super.key});

  @override
  NewHabitScreenStore createWStore() => NewHabitScreenStore();

  @override
  Widget build(BuildContext context, NewHabitScreenStore store) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: 'New Habbit',
        showBack: true,
      ),
      body: const SafeArea(
        child: NewHabitScreenContent(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PrimaryActionButton(
        icon: Image.asset(
          'assets/images/check.png',
        ),
        onPressed: () {},
      ),
    );
  }
}

class NewHabitScreenContent extends StatelessWidget {
  const NewHabitScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
