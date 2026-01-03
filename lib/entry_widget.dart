import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayertracker/constants.dart';
import 'package:prayertracker/entries_provider.dart';
import 'package:prayertracker/entry.dart';

Widget entryDateWidget(DateTime date) => Expanded(child: Text(Constants.uiDateFormat.format(date)));

class PrayerBox extends ConsumerWidget {
  final String id;
  final PrayerValue prayerValue;
  final PrayerKind prayerKind;
  const PrayerBox(this.id, this.prayerValue, this.prayerKind, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void prayerBoxTapped() {
      ref.read<Entries>(entriesProvider.notifier).update(id, prayerKind);
      log(name: 'Logic', 'Toggled the ${prayerKind.name} prayerButton of $id');
    }

    final currentPrayerValue = ref.watch(
      entriesProvider.select((value) => value[id]?.getPrayerValue(prayerKind)),
    );
    final buttonColor = Constants.prayerValueToColor[currentPrayerValue];
    final isTodaysButton = (id == Entry.dateFormat().format(DateTime.now()));

    final Container prayerBox = Container(
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(
          width: 1,
          color: buttonColor == Colors.transparent ? Colors.grey : Colors.transparent,
        ),
      ),
      width: 30,
      height: 30,
    );

    final GestureDetector clickablePrayerBox = GestureDetector(
      onTap: prayerBoxTapped,
      child: prayerBox,
    );

    // log(name: 'UI', 'Building prayerButton "$id", kind "${prayerKind.name}"');

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: isTodaysButton ? clickablePrayerBox : prayerBox,
    );
  }
}

class EntryWidget extends ConsumerWidget {
  final Entry entry;
  const EntryWidget({super.key, required this.entry});

  PrayerBox prayerButton(PrayerKind pk) {
    String id = Entry.dateFormat().format(entry.date);
    return PrayerBox(id, entry.getPrayerValue(pk), pk);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          entryDateWidget(entry.date),
          prayerButton(PrayerKind.morning),
          prayerButton(PrayerKind.noon),
          prayerButton(PrayerKind.afternoon),
          prayerButton(PrayerKind.night),
          prayerButton(PrayerKind.evening),
        ],
      ),
    );
  }
}
