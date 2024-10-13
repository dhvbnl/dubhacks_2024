import 'dart:convert';

import 'package:dubhacks/models/still.dart';
import 'package:dubhacks/providers/still_provider.dart';
import 'package:dubhacks/views/homepage/homepage.dart';
import 'package:dubhacks/helpers/prompt_manager.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // sets up local storage
  await Hive.initFlutter();
  Hive.registerAdapter(StillAdapter());

  // create a secure storage
  const secureStorage = FlutterSecureStorage();

  // takes key from secure storage, returns null if not found
  var encryptionKey = await secureStorage.read(key: 'key');
  if (encryptionKey == null) {
    // generates if it does not exist
    final key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    encryptionKey = await secureStorage.read(key: 'key');
  }
  // decodes key
  final decodedKey = base64Url.decode(encryptionKey!);
  // gets box of Stills using cipher
  Box<Still> encryptedBox = await Hive.openBox<Still>('Still Data Storage',
      encryptionCipher: HiveAesCipher(decodedKey));

  final promptBox = await Hive.openBox<String>('Prompt Data Storage');
  final promptManager = PromptManager(promptBox, []);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) =>
          runApp((MyApp(storage: encryptedBox, promptManager: promptManager))));
}

class MyApp extends StatefulWidget {
  final Box<Still> storage;
  final PromptManager promptManager;

  const MyApp({super.key, required this.storage, required this.promptManager});

  PromptManager get getPromptManager => promptManager;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData mTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(255, 255, 255, 1)));

  final cupertinoTheme = const CupertinoThemeData(
      primaryColor: Color.fromARGB(255, 255, 255, 255),
      barBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      scaffoldBackgroundColor: Colors.white);
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: false,
        iosUseZeroPaddingForAppbarPlatformIcon: false,
      ),
      builder: (context) => PlatformTheme(
        materialLightTheme: mTheme,
        materialDarkTheme: mTheme,
        cupertinoLightTheme: cupertinoTheme,
        cupertinoDarkTheme: cupertinoTheme,
        builder: (context) => PlatformApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: 'Flutter Platform Widgets',
          home: ChangeNotifierProvider(
            create: (context) => StillsProvider(storage: widget.storage),
            child: HomePage(promptManager: widget.getPromptManager),
          ),
        ),
      ),
    );
  }
}
