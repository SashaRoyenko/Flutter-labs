import 'dart:math';
import 'dart:ui';

class ColorService{

  Color createRandomColor() {
    int red = _getRandomNumber();
    int green = _getRandomNumber();
    int blue = _getRandomNumber();
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  Color getColorFromHex(String color) {
    String colorHex = color.replaceAll("Color(", "");
    colorHex = colorHex.replaceAll(")", "");
    return Color(int.parse(colorHex));
  }

  int _getRandomNumber() => Random().nextInt(255);
}
