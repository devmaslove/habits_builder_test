import 'package:flutter/material.dart';
import 'package:habits_builder_test/resources/app_colors.dart';
import 'package:habits_builder_test/widgets/primary_action_button.dart';
import 'package:habits_builder_test/widgets/primary_app_bar.dart';
import 'package:wstore/wstore.dart';

class NewHabitScreenStore extends WStore {
  @override
  NewHabitScreen get widget => super.widget as NewHabitScreen;

  bool checkNotification = false;

  void switchNotification() {
    setStore(() => checkNotification = !checkNotification);
  }

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
        title: 'New Habit',
        showBack: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: NewHabitScreenContent(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PrimaryActionButton(
        icon: Image.asset(
          'assets/images/check.png',
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        shape: const CircularNotchedRectangleEx(),
        child: SizedBox(
          height: 80,
          child: Row(
            children: const [
              Text(''),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularNotchedRectangleEx extends NotchedShape {
  const CircularNotchedRectangleEx();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    Offset p2 = Offset(host.center.dx - 92, host.top);
    Offset p2Control1 = Offset(host.center.dx - 42, host.top);
    Offset p2Control2 = Offset(host.center.dx - 28, host.top + 32);
    Offset p3 = Offset(host.center.dx, host.top + 32);
    Offset p3Control1 = Offset(host.center.dx + 28, host.top + 32);
    Offset p3Control2 = Offset(host.center.dx + 42, host.top);
    Offset p4 = Offset(host.center.dx + 92, host.top);

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p2.dx, p2.dy)
      ..cubicTo(
        p2Control1.dx,
        p2Control1.dy,
        p2Control2.dx,
        p2Control2.dy,
        p3.dx,
        p3.dy,
      )
      ..cubicTo(
        p3Control1.dx,
        p3Control1.dy,
        p3Control2.dx,
        p3Control2.dy,
        p4.dx,
        p4.dy,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

class NewHabitScreenContent extends StatelessWidget {
  const NewHabitScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                  hintText: 'Enter habit name',
                ),
              ),
            ),
            const SizedBox(width: 12),
            DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/circle-plus.png'),
                  alignment: Alignment.topRight,
                  fit: BoxFit.none,
                ),
              ),
              position: DecorationPosition.foreground,
              child: Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.only(top: 4, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset('assets/images/book.png'),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: HabitFrequency(),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {},
              child: Ink(
                height: 48,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        'Reminder',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      '10:00AM',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary3,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset('assets/images/right.png'),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                context.wstore<NewHabitScreenStore>().switchNotification();
              },
              child: Ink(
                height: 48,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    WStoreValueBuilder<NewHabitScreenStore, bool>(
                      watch: (store) => store.checkNotification,
                      builder: (context, check) {
                        return OnOffSwitcher(check: check);
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnOffSwitcher extends StatelessWidget {
  final bool check;
  final _animationDuration = const Duration(milliseconds: 150);

  const OnOffSwitcher({
    super.key,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 30,
      decoration: BoxDecoration(
        color: _getBackColor(check),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: check ? 28 : 4,
            top: 4,
            duration: _animationDuration,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: _getMainColor(check),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _getMainColor(check).withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(check ? 2 : -2, 3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: check ? 8 : 32,
            top: 7,
            child: Text(
              _getText(check),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: _getMainColor(check),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackColor(bool check) {
    if (check) return AppColors.secondary3.withOpacity(0.2);
    return AppColors.primary.withOpacity(0.1);
  }

  Color _getMainColor(bool check) {
    if (check) return AppColors.secondary3;
    return AppColors.primary;
  }

  String _getText(bool check) {
    return check ? 'On' : 'Off';
  }
}

class HabitFrequency extends StatelessWidget {
  const HabitFrequency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Ink(
                height: 48,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        'Habit Frequency',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Custom',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary3,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset('assets/images/right.png'),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.bg),
          SizedBox(
            height: 84,
            child: Row(
              children: const [
                WeekDayFrequency(day: 'Sun', half: false),
                VerticalDivider(),
                WeekDayFrequency(day: 'Mon', half: true),
                VerticalDivider(),
                WeekDayFrequency(day: 'Tue', half: true),
                VerticalDivider(),
                WeekDayFrequency(day: 'Wed', half: false),
                VerticalDivider(),
                WeekDayFrequency(day: 'Thu', half: true),
                VerticalDivider(),
                WeekDayFrequency(day: 'Fri', half: false),
                VerticalDivider(),
                WeekDayFrequency(day: 'Sat', half: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 1,
      height: double.infinity,
      child: ColoredBox(
        color: AppColors.bg,
      ),
    );
  }
}

class WeekDayFrequency extends StatelessWidget {
  final String day;
  final bool half;

  const WeekDayFrequency({
    super.key,
    required this.day,
    required this.half,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            day.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              height: 13 / 10,
              fontWeight: FontWeight.w700,
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 38,
            width: 38,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.secondary2.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: half
                ? ClipPath(
                    clipper: CustomHalfCircleClipper(),
                    child: const ColoredBox(color: AppColors.secondary2),
                  )
                : DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.secondary2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 8);
    path.quadraticBezierTo(2, 2, 8, 10);
    path.lineTo(size.width - 10, size.height - 8);
    path.quadraticBezierTo(
      size.width - 2,
      size.height - 2,
      size.width - 8,
      size.height,
    );
    path.lineTo(12, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 12);
    path.lineTo(0, 8);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
