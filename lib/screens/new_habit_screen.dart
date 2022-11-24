import 'package:flutter/material.dart';
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
    return Container();
  }
}
