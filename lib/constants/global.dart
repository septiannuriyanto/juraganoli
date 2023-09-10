import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

TextStyle defaultBold = const TextStyle(fontWeight: FontWeight.w800);
TextStyle greyTxt = TextStyle(color: Colors.grey.shade400);
TextStyle txt10 = const TextStyle(fontSize: 10);
TextStyle txt11 = const TextStyle(fontSize: 11);
TextStyle txt12 = const TextStyle(fontSize: 12);
TextStyle txt13 = const TextStyle(fontSize: 13);
TextStyle txt14 = const TextStyle(fontSize: 14);
TextStyle txt15 = const TextStyle(fontSize: 15);
TextStyle txt16 = const TextStyle(fontSize: 16);
TextStyle txt17 = const TextStyle(fontSize: 17);

final TokpedGreen = HexColor('19B715');
final TokpedDarkGreen = HexColor('128a3c');

final shadowPanel = [
  BoxShadow(
    color: Colors.grey.shade600,
    spreadRadius: 1,
    blurRadius: 5,
    offset: const Offset(0, 5),
  ),
  // BoxShadow(
  //   color: Colors.grey.shade300,
  //   offset: const Offset(-5, 0),
  // )
];

final subtleShadow = [
  BoxShadow(
    color: Colors.grey.shade100, //HexColor('9F9F9F'),
    spreadRadius: 2,
    blurRadius: 2,
    offset: const Offset(0, 4),
  ),
];

rads(double radius) {
  return BorderRadius.all(Radius.circular(radius));
}

bord() {
  Border.all(color: Colors.grey.shade400);
}
