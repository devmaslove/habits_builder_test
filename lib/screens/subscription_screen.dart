import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/widgets/primary_app_bar.dart';
import 'package:wstore/wstore.dart';

class SubscriptionScreenStore extends WStore {
  static const _offerTimerId = 1;
  Duration offerTime = const Duration(days: 1);

  void startOfferTimer() {
    setInterval(
      () {
        if (offerTime.inSeconds > 0) {
          setStore(() => offerTime -= const Duration(seconds: 1));
        } else {
          killTimer(timerId: _offerTimerId);
        }
      },
      1000,
      _offerTimerId,
    );
  }

  @override
  SubscriptionScreen get widget => super.widget as SubscriptionScreen;
}

class SubscriptionScreen extends WStoreWidget<SubscriptionScreenStore> {
  const SubscriptionScreen({super.key});

  @override
  SubscriptionScreenStore createWStore() =>
      SubscriptionScreenStore()..startOfferTimer();

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
    return Column(
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: WhiteBoard146(
            rightAssetPosition: -65,
            topAssetPosition: -42,
            widthAsset: 266,
            heightAsset: 266,
            asset: 'assets/images/teepee.png',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '60% off your upgrade',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1,
                      color: AppColors.secondary3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Expires in',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 14 / 12,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  WStoreValueBuilder<SubscriptionScreenStore, Duration>(
                    watch: (store) => store.offerTime,
                    builder: (context, value) {
                      return SubscriptionTimer(value: value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SubscriptionTimer extends StatelessWidget {
  final Duration value;

  const SubscriptionTimer({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimerValue(value: value.inHours % Duration.hoursPerDay),
        const TimerSemiColumn(),
        TimerValue(value: value.inMinutes % Duration.minutesPerHour),
        const TimerSemiColumn(),
        TimerValue(value: value.inSeconds % Duration.secondsPerMinute),
      ],
    );
  }
}

class TimerValue extends StatelessWidget {
  final int value;

  const TimerValue({
    super.key,
    required this.value,
  });

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        _twoDigits(value),
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class TimerSemiColumn extends StatelessWidget {
  const TimerSemiColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 16,
      child: Center(
        child: Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class WhiteBoard146 extends StatelessWidget {
  final Widget child;
  final String asset;
  final double? rightAssetPosition;
  final double? topAssetPosition;
  final double? widthAsset;
  final double? heightAsset;

  const WhiteBoard146({
    super.key,
    required this.child,
    required this.asset,
    this.rightAssetPosition,
    this.topAssetPosition,
    this.widthAsset,
    this.heightAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      height: 146,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: rightAssetPosition,
            top: topAssetPosition,
            width: widthAsset,
            height: heightAsset,
            child: Image.asset(
              asset,
              fit: BoxFit.scaleDown,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
