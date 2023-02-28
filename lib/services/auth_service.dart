import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/database_controller.dart';
import 'package:qoutes_app/controllers/quotesController.dart';
import 'package:qoutes_app/controllers/user_controller.dart';
import 'package:qoutes_app/services/database_service.dart';
import 'package:qoutes_app/views/app_navigation.dart';
import 'package:qoutes_app/views/login.dart';

import 'package:qoutes_app/views/widgets/customSnackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserController userController = Get.find(tag: "userController");
  QuoteController quoteController = Get.find(tag: 'quoteController');
  DatabaseController databaseController = Get.find(tag: 'databaseController');
  Future<void> autoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uid = sharedPreferences.getString('uid') ?? "";
    String email = sharedPreferences.getString('email') ?? "";
    bool signedIn = sharedPreferences.getBool('signedIn') ?? false;
    String profilePicLink = sharedPreferences.getString('profilePicLink') ?? "";
    if (signedIn) {
      userController.setUser(email, uid, profilePicLink: profilePicLink);
      await quoteController.init();

      Get.to(AppNavigation());
    } else {
      Get.to(LoginPage());
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveToPref(credential);

      userController.setUser(email, credential.user!.uid,
          profilePicLink: databaseController.uploadedFileLink);

      await quoteController.init();
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        generateError("Weak Password", "The password provided is too weak.");
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        generateError("Email Already Exists",
            "The account already exists for that email.");
        return e.code;
      } else {
        return "Something went wrong.";
      }
    } catch (e) {
      return "Something went wrong.";
    }
  }

  saveToPref(UserCredential userCredential,
      {String profilePicLink = ""}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('uid', userCredential.user!.uid);
    await sharedPreferences.setString(
        'email', userCredential.user!.email ?? "");
    await sharedPreferences.setString('profilePicLink', profilePicLink);
    await sharedPreferences.setBool('signedIn', true);
  }

  Future<String> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String profilePicLink =
          DatabaseService().getUserProfilePic(credential.user!.uid);

      userController.setUser(email, credential.user!.uid,
          profilePicLink: profilePicLink);

      saveToPref(
        credential,
      );
      await quoteController.init();
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return "Something went wrong.";
      }
    }
  }

  Future<void> signOut() async {
    userController.user.userID = "";
    userController.user.email = "";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    await auth.signOut();
    Get.to(LoginPage());
  }
}
