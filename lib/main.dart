import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/database_controller.dart';
import 'package:qoutes_app/controllers/language_controller.dart';
import 'package:qoutes_app/controllers/quotesController.dart';
import 'package:qoutes_app/controllers/user_controller.dart';
import 'package:qoutes_app/firebase_options.dart';
import 'package:qoutes_app/views/app_navigation.dart';
import 'package:qoutes_app/views/login.dart';
import 'package:qoutes_app/views/setting_screen.dart';
import 'package:qoutes_app/views/splash_screen.dart';

import 'package:flutter_localization/flutter_localization.dart';
import 'package:qoutes_app/views/utils/app_locals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInit();

  runApp(const MyApp());
}

Future<void> firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, //auto choose from firebase_options file present in lib folder
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  void initState() {
    Get.put(UserController(), tag: 'userController');
    Get.put(DatabaseController(), tag: 'databaseController');
    Get.put(QuoteController(), tag: 'quoteController');
    Get.put(LanguageController(), tag: 'languageController');
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('km', AppLocale.KM),
        const MapLocale('eb', AppLocale.EB),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = onTranslatedLanguage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        title: 'Quotes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen()
        //AppNavigation(),
        );
  }
}
