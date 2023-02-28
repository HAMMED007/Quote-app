import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:qoutes_app/views/app_navigation.dart';
import 'package:qoutes_app/views/login.dart';
import 'package:qoutes_app/views/styles.dart';
import 'package:qoutes_app/views/utils/app_locals.dart';
import 'package:qoutes_app/views/widgets/lang_switch.dart';
import 'package:qoutes_app/views/widgets/text_fields.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isEng = true;
  bool termsAccepted = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      AppLocale.quotesApp.getString(context),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                LangSwitch()
              ],
            ),
            const SizedBox(
              height: 120,
            ),
            Text(
              AppLocale.forgetPassword.getString(context),
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFields(
              textController: emailController,
              titleText: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () => {Get.to(AppNavigation())},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 25),
                  child: Text(
                    AppLocale.recoverYourPassword.getString(context),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => {Get.to(LoginPage())},
                    child: Text(
                      AppLocale.rememberYourPassword.getString(context),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            )
          ],
        ),
      ) /* add child content here */,
    ));
  }
}
