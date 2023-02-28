import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/quotesController.dart';
import 'package:qoutes_app/services/auth_service.dart';
import 'package:qoutes_app/views/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/qoutes.png',
            fit: BoxFit.cover,
            width: 120.0,
            color: blackColor,
          ),
          const SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            color: blackColor,
            value: null,
            strokeWidth: 4.0,
          ),
        ],
      )),
    );
  }
}

redirect() async {
  debugPrint("redirecting......");

  await AuthService().autoLogin();
}
