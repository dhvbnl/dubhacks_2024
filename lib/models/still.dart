import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'still.g.dart';

// Still is a class that represents a still image with a prompt and a date.
@HiveType(typeId: 0)
class Still extends HiveObject {
  // Unique identifier for the still.
  @HiveField(0)
  String id;
  // String which describes image prompt.
  @HiveField(1)
  final String prompt;
  // Time when photo was taken.
  @HiveField(2)
  final DateTime date;
  // Image of the still.
  @HiveField(3)
  final String path;

  // Constructor
  Still(
      {required this.id,
      required this.prompt,
      required this.date,
      required this.path});

  // Factory constructor
  factory Still.create({
    required String prompt,
    required String path,
  }) {
    return Still(
      id: const Uuid().v4(),
      prompt: prompt,
      date: DateTime.now(),
      path: path,
    );
  }

  // Returns the prompt of the Still object.
  String get getPrompt => prompt;

  // Returns the date of the Still object.
  DateTime get getDate => date;

  // Returns the photo of the Still object.
  String get getPhoto => path; // Returns a copy of the Image.
}
