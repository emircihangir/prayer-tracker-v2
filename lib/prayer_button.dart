import 'package:flutter/widgets.dart';

enum ButtonState { empty, half, full }

enum ButtonType { morning, noon, afternoon, night, evening }

class Prayerbutton extends StatelessWidget {
  late final ButtonType _buttonType;
  late final ButtonState _state;

  Prayerbutton({super.key, required ButtonType buttonType, ButtonState state = ButtonState.empty}) {
    _buttonType = buttonType;
    _state = state;
  }

  /// Forwards the button's state.
  ///
  /// Order: empty -> half -> full
  void forward() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
