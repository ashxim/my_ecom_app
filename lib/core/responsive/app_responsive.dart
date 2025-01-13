import 'package:flutter/material.dart';

class ScreenSize {
  // ignore: non_constant_identifier_names
  BuildContext(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
  }
}
