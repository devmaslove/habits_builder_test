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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        shape: const CircularNotchedRectangleEx(),
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Text('Hello'),
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
    return Container();
  }
}
