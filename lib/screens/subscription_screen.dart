import 'package:flutter/material.dart';
import 'package:habits_builder_test/widgets/primary_app_bar.dart';
import 'package:wstore/wstore.dart';

class SubscriptionScreenStore extends WStore {
  // TODO: add data here...

  @override
  SubscriptionScreen get widget => super.widget as SubscriptionScreen;
}

class SubscriptionScreen extends WStoreWidget<SubscriptionScreenStore> {
  const SubscriptionScreen({super.key});

  @override
  SubscriptionScreenStore createWStore() => SubscriptionScreenStore();

  @override
  Widget build(BuildContext context, SubscriptionScreenStore store) {
    return const Scaffold(
      appBar: PrimaryAppBar(
        title: 'Premium',
        showBack: true,
      ),
      body: SafeArea(
        child: SubscriptionScreenContent(),
      ),
    );
  }
}

class SubscriptionScreenContent extends StatelessWidget {
  const SubscriptionScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
