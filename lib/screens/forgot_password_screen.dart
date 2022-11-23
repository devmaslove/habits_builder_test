import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/resources/app_styles.dart';
import 'package:wstore/wstore.dart';

class ForgotPasswordScreenStore extends WStore {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 84,
        title: SizedBox(
          height: 84,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  splashRadius: 22,
                  padding: EdgeInsets.zero,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: ForgotPasswordScreenContent(),
      ),
    );
  }
}

class ForgotPasswordScreenContent extends StatelessWidget {
  const ForgotPasswordScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Forgot your password?'.toUpperCase(),
            style: AppStyles.title.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Center(
            child: Image.asset(
              'assets/images/forgot.png',
              fit: BoxFit.scaleDown,
              width: 310,
              height: 310,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: EnterEmailForm(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            child: const Text.rich(
              TextSpan(
                text: 'Remember password? ',
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                height: 22 / 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class EnterEmailForm extends StatelessWidget {
  const EnterEmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Enter your registered email below to '
            'receive password reset instruction',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 22 / 14,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          TextFormField(
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontSize: 16,
              height: 24 / 16,
              color: AppColors.secondary3,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondary2.withOpacity(0.1),
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                gapPadding: 0,
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color: AppColors.primary.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary2,
              elevation: 0,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Send Reset Link',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
