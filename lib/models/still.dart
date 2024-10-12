import 'package:flutter/cupertino.dart';

class Still {
  final String _prompt;
  final DateTime _date;
  final AssetImage _photo;

  Still(String prompt, NetworkImage photo)
      : _prompt = prompt,
        _date = DateTime.now(),
        _photo =
            photo; // Assuming copyImage is a function that returns a copy of the Image.

  String get getPrompt => _prompt;

  DateTime get getDate =>
      _date; // Returns a copy of DateTime with hour and minute.

  AssetImage get getPhoto => _photo; // Returns a copy of the Image.
}
