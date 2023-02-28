import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:qoutes_app/services/auth_service.dart';
import 'package:qoutes_app/views/app_navigation.dart';
import 'package:qoutes_app/views/forget_password.dart';
import 'package:qoutes_app/views/login.dart';
import 'package:qoutes_app/views/styles.dart';
import 'package:qoutes_app/views/utils/app_locals.dart';
import 'package:qoutes_app/views/widgets/customSnackbar.dart';
import 'package:qoutes_app/views/widgets/lang_switch.dart';
import 'package:qoutes_app/views/widgets/pick_image.dart';
import 'package:qoutes_app/views/widgets/text_fields.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isEng = true;
  bool termsAccepted = true;
  AuthService authService = AuthService();
  String result = "";
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
              height: 20,
            ),
            SizedBox(
                height: 130,
                child: PickAndUploadImage(firebasePath: "profile_pics")),
            TextFields(
              textController: emailController,
              titleText: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            TextFields(
              obscureText: true,
              textController: passwordController,
              titleText: AppLocale.password.getString(context),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: blackColor,
                  value: termsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      termsAccepted = value!;
                    });
                  },
                ),
                Text(
                  AppLocale.iAgreeToThe.getString(context),
                  style: TextStyle(color: darkGreyColor),
                ),
                Text(
                  AppLocale.termsAndContion.getString(context),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () => {Get.to(ForgetPassword())},
                child: Text(
                  AppLocale.forgetPassword.getString(context),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
                onPressed: () async => {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty)
                        {
                          Get.snackbar("Error", "Please fill all the fields",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white)
                        }
                      else if (!termsAccepted)
                        {
                          Get.snackbar("Error", "Please accept the terms",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white)
                        }
                      else
                        {
                          customLoadingDialog(),
                          result = await authService.signUp(
                              emailController.text, passwordController.text),
                          Get.back(),
                          if (result == "success")
                            {
                              Get.offAll(AppNavigation()),
                            }
                          else if (result == 'weak-password')
                            {
                              generateError("Weak Password",
                                  "The password provided is too weak."),
                              print('The password provided is too weak.')
                            }
                          else if (result == 'email-already-in-use')
                            {
                              generateError("Email Already Exists",
                                  "The account already exists for that email."),
                              print(
                                  'The account already exists for that email.'),
                            }
                          else
                            {
                              generateError("Error", "Something went wrong"),
                              print(result),
                            }
                        }
                    },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 120.0, vertical: 25),
                  child: Text(
                    AppLocale.signUp.getString(context),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () => {Get.to(LoginPage())},
                child: Text(
                  AppLocale.loginInstead.getString(context),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ) /* add child content here */,
    ));
  }
}
