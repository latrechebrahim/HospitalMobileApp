

import 'package:flutter/material.dart';

class AppTheme {
  static const Color dark = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white1 = Color.fromARGB(255, 126, 126, 126);
  static const Color blue = Color(0xFF3B7BC7);
  static const Color blue1 = Color(0xFF0000FF);
  static const Color gry = Color(0xFFE8E8E8);
  static const Color red = Color.fromARGB(255, 249, 7, 7);
  static const Gradient background = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFF3B7BC7),
      ]
  );
}
class AppIcons {
  static const IconData calendar_today = IconData(
    0xe122, fontFamily: 'MaterialIcons',);
  static const IconData settings = IconData(
      0xe57f, fontFamily: 'MaterialIcons');
  static const IconData logout = IconData(
      0xe3b3, fontFamily: 'MaterialIcons');
  static const IconData support_agent = IconData(0xe621, fontFamily: 'MaterialIcons');
  static const IconData phone = IconData(0xe4a2, fontFamily: 'MaterialIcons');

}

