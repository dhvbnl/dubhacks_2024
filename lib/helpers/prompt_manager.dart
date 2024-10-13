import 'prompts.dart';
import 'package:hive/hive.dart';

class PromptManager {
  // to store the prompt for today with hive
  final Box _box;
  // prompts to choose from
  List<String> unusedPrompts = [];
  // pull the whole list from other file
  final List<String> prompts;

  // set the unused prompts
  PromptManager(this._box, this.prompts) {
    var storedPrompts = _box.get('unusedPrompts');
    prompts.addAll(allPrompts);

    // Debug: print type of storedPrompts to catch issues

    // If storedPrompts exists
    if (storedPrompts != null) {
      unusedPrompts = List<String>.from(storedPrompts);
    } else {
      // If nothing exists in Hive, initialize unusedPrompts with all prompts
      unusedPrompts = prompts;
      _box.put('unusedPrompts',
          unusedPrompts.toString()); // Store it safely as a list
    }
  }

  String getPrompt() {
    // get the date key to check Hive
    final today = DateTime.now();
    final String todaykey = '${today.year}-${today.month}-${today.day}-prompt';

    // if there is a prompt for today, return it
    String? prompt = _box.get(todaykey);
    if (prompt != null) {
      return prompt;
    }

    // if there is no prompt for today, get a new one
    if (unusedPrompts.isEmpty) {
      unusedPrompts = allPrompts.toList();
    }

    // get a random prompt
    unusedPrompts.shuffle();
    prompt = unusedPrompts.removeLast();

    // save the prompt for today
    _box.put(todaykey, prompt);
    _box.put('unusedPrompts', unusedPrompts.toString());

    return prompt;
  }
}
