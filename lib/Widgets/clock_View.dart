import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/Provider/clock_Provider.dart';
import 'package:timer/Widgets/clock_Painter.dart';

// Rest of your code

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClockState(),
      child: Consumer<ClockState>(
        builder: (context, clockState, _) {
          return SizedBox(
            height: 300,
            width: 300,
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          );
        },
      ),
    );
  }
}
