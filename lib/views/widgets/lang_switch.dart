import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/language_controller.dart';
import 'package:qoutes_app/views/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangSwitch extends StatefulWidget {
  const LangSwitch({super.key});

  @override
  State<LangSwitch> createState() => _LangSwitchState();
}

class _LangSwitchState extends State<LangSwitch> {
  LanguageController languageController = Get.find(tag: 'languageController');

  bool isEng = true;
  final FlutterLocalization localization = FlutterLocalization.instance;
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Switch(
          activeColor: secondaryColor,
          activeThumbImage: const AssetImage("assets/eng.png"),
          inactiveThumbImage: const AssetImage("assets/est.png"),
          value: languageController.isEng,
          onChanged: (bool val) async => {
                sharedPreferences = await SharedPreferences.getInstance(),
                sharedPreferences.setBool('isEng', val),
                localization.translate(val ? 'en' : 'eb'),
                setState(() {
                  languageController.isEng = val;
                })
              }),
    );
  }
}
