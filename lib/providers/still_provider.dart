import 'package:flutter/material.dart';
import 'package:dubhacks/models/still.dart';
import 'package:hive/hive.dart';

///Creates a JournalProvider to moniter updates to the journal
class StillsProvider extends ChangeNotifier {
  final List<Still> _stills;

  final Box<Still> _storage;

  StillsProvider({
    required Box<Still> storage,
  })  : _storage = storage,
        _stills = List.from(storage.values);

  upsertStill(Still still) {
    _stills.add(still);
    _storage.put(still.id, still);
    notifyListeners();
  }

  removeEntry(Still still) {
    _stills.remove(still);
    _storage.delete(still.id);
    notifyListeners();
  }

  List<Still> get getStills => _stills;
}
