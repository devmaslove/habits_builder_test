import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/widgets/primary_app_bar.dart';
import 'package:wstore/wstore.dart';

class SubscriptionScreenStore extends WStore {
  static const _offerTimerId = 1;
  Duration _offerTime = const Duration(hours: 23, minutes: 59, seconds: 59);

  int get timerHours => computed(
        getValue: () => _offerTime.inHours % Duration.hoursPerDay,
        watch: () => [_offerTime],
        keyName: 'timerHours',
      );

  int get timerMinutes => computed(
        getValue: () => _offerTime.inMinutes % Duration.minutesPerHour,
        watch: () => [_offerTime],
        keyName: 'timerMinutes',
      );

  int get timerSeconds => computed(
        getValue: () => _offerTime.inSeconds % Duration.secondsPerMinute,
        watch: () => [_offerTime],
        keyName: 'timerSeconds',
      );

  void startOfferTimer() {
    setInterval(
      () {
        if (_offerTime.inSeconds > 0) {
          setStore(() => _offerTime -= const Duration(seconds: 1));
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
                  const SubscriptionTimer(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: UnlockFeatures(),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: PriceBadge(
                  price: '\$19.00',
                  period: 'Monthly',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: PriceBadge(
                  title: 'Most Popular',
                  price: '\$29.00',
                  period: 'Yearly',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: PriceBadge(
                  price: '\$49.00',
                  period: 'Lifetime',
                  discount: '-75%',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceBadge extends StatelessWidget {
  final String? title;
  final String price;
  final String period;
  final String? discount;

  const PriceBadge({
    super.key,
    this.title,
    this.discount,
    required this.price,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            children: [
              if (title != null)
                SizedBox(
                  height: 32,
                  child: ColoredBox(
                    color: AppColors.secondary3,
                    child: Center(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              if (title != null) const Divider(height: 1, color: AppColors.bg),
              SizedBox(
                height: 92,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: AppColors.secondary3,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '6-month plan for 39.99 usd',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          height: 13 / 10,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.bg),
              SizedBox(
                height: 28,
                child: Center(
                  child: Text(
                    period,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (discount != null)
            Positioned(
              width: 80,
              height: 28,
              bottom: 0,
              right: -40,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: const ColoredBox(
                  color: AppColors.secondary3,
                ),
              ),
            ),
          if (discount != null)
            Positioned(
              bottom: 4,
              width: 32,
              right: -4,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Text(
                  discount!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 10,
                    height: 14 / 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class UnlockFeatures extends StatelessWidget {
  const UnlockFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: Column(
        children: const [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Unlock Monumental Habits',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          Divider(height: 1, color: AppColors.bg),
          UnlockCheckFeature(text: 'Unlimited habits'),
          Divider(height: 1, color: AppColors.bg),
          UnlockCheckFeature(text: 'Access to all courses'),
          Divider(height: 1, color: AppColors.bg),
          UnlockCheckFeature(text: 'Access to all avatar illustrations'),
        ],
      ),
    );
  }
}

class UnlockCheckFeature extends StatelessWidget {
  final String text;

  const UnlockCheckFeature({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/check-boll.png',
            width: 22,
            height: 22,
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class SubscriptionTimer extends StatelessWidget {
  const SubscriptionTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WStoreValueBuilder<SubscriptionScreenStore, int>(
          watch: (store) => store.timerHours,
          builder: (context, hours) {
            return TimerValue(value: hours);
          },
        ),
        const TimerSemiColumn(),
        WStoreValueBuilder<SubscriptionScreenStore, int>(
          watch: (store) => store.timerMinutes,
          builder: (context, minutes) {
            return TimerValue(value: minutes);
          },
        ),
        const TimerSemiColumn(),
        WStoreValueBuilder<SubscriptionScreenStore, int>(
          watch: (store) => store.timerSeconds,
          builder: (context, seconds) {
            return TimerValue(value: seconds);
          },
        ),
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
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 11),
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
