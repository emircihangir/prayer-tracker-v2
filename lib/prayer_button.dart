// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayertracker/main.dart';

enum PrayerValue {
  empty(0, Colors.white, Colors.grey),
  half(1, Colors.grey, Colors.grey),
  full(2, Colors.black, Colors.black);

  final int value;
  final Color colorValue;
  final Color borderColor;
  const PrayerValue(this.value, this.colorValue, this.borderColor);
}

enum ButtonType { morning, noon, afternoon, night, evening }

class PrayerButton extends ConsumerStatefulWidget {
  final ButtonType buttonType;
  final PrayerValue initialButtonState;
  final String buttonID;

  const PrayerButton({
    super.key,
    required this.buttonID,
    required this.buttonType,
    this.initialButtonState = PrayerValue.empty,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrayerButtonState();
}

class _PrayerButtonState extends ConsumerState<PrayerButton> {
  @override
  void initState() {
    log('Creating ${widget.buttonID}', name: 'UI');

    ref.read(buttonStates.notifier).state[widget.buttonID] = widget.initialButtonState.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Building ${widget.buttonID}', name: 'UI');

    final currentButtonStateValue = ref.watch(
      buttonStates.select((value) => value[widget.buttonID]),
    )!;
    final currentButtonState = PrayerValue.values[currentButtonStateValue % 3];

    return GestureDetector(
      onTap: () {
        final PrayerValue newButtonState = PrayerValue.values[(currentButtonStateValue + 1) % 3];
        ref.read(buttonStates.notifier).update((state) {
          return {...state, widget.buttonID: newButtonState.value};
        });

        HapticFeedback.lightImpact();

        log("Updated ${widget.buttonID}'s state to ${newButtonState.name}", name: 'UI');
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: currentButtonState.colorValue,
            shape: BoxShape.circle,
            border: BoxBorder.all(color: currentButtonState.borderColor, width: 2),
          ),
        ),
      ),
    );
  }
}
