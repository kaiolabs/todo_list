import 'package:flutter/cupertino.dart';

class PreferencesTheme {
  static ValueNotifier<Brightness> brightness = ValueNotifier<Brightness>(Brightness.light);

  static setTema(Brightness brightness) {
    brightness = brightness;
  }

  static toggleTema() {
    brightness.value = brightness.value == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
