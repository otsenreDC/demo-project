class Delays {
  static Future milliseconds(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds), () => "1");
  }
}
