import 'package:flutter/material.dart';
import 'package:wstore/wstore.dart';

class ForgotPasswordScreenStore extends WStore {
  // TODO: add data here...

  @override
  ForgotPasswordScreen get widget => super.widget as ForgotPasswordScreen;

  static ForgotPasswordScreenStore of(BuildContext context) {
    return WStoreWidget.store<ForgotPasswordScreenStore>(context);
  }
}

class ForgotPasswordScreen extends WStoreWidget<ForgotPasswordScreenStore> {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenStore createWStore() => ForgotPasswordScreenStore();

  @override
  Widget build(BuildContext context, ForgotPasswordScreenStore store) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ForgotPasswordScreenContent(),
      ),
    );
  }
}

class ForgotPasswordScreenContent extends StatelessWidget {
  const ForgotPasswordScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
