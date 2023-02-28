import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  bool isEng = true;
  @override
  Future<void> onInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isEng = sharedPreferences.getBool('isEng') ?? true;

    super.onInit();
  }

  void changeLanguage() {
    isEng = !isEng;
    update();
  }
}
