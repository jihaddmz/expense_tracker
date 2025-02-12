import 'dart:math';

class Helpers {
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return List.generate(length, (index) => chars[rnd.nextInt(chars.length)]).join();
  }
}