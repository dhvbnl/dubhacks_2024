import 'package:flutter/material.dart';
import 'package:dubhacks/models/still.dart';

///Creates a JournalProvider to moniter updates to the journal
class StillsProvider extends ChangeNotifier {
  final List<Still> _stills;

  StillsProvider(stills) : _stills = stills;

  upsertStill(Still still) {
    _stills.add(still);
    notifyListeners();
  }

  removeEntry(Still still) {
    _stills.remove(still);
    notifyListeners();
  }
}
