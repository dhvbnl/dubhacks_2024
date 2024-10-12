import 'package:image/image.dart';

class Still {
  final String _prompt;
  final DateTime _date;
  final Image _photo;

  Still(String prompt, Image photo)
      : _prompt = prompt,
        _date = DateTime.now(),
        _photo = copyImage(
            photo); // Assuming copyImage is a function that returns a copy of the Image.

  String get getPrompt => _prompt;

  DateTime get getDate =>
      _date; // Returns a copy of DateTime with hour and minute.

  Image get getPhoto => copyImage(_photo); // Returns a copy of the Image.

  // Create Image copy
  static Image copyImage(Image original) {
    return Image.from(original);
  }
}
