import 'package:get/get.dart';
import 'package:qoutes_app/models/user.dart';
import 'package:qoutes_app/services/auth_service.dart';
import 'package:qoutes_app/services/database_service.dart';

class UserController extends GetxController {
  late User user;
  setUser(String email, String userID, {String profilePicLink = ""}) async {
    user = User(
      email: email,
      userID: userID,
      profilePictureLink: profilePicLink,
    );
    DatabaseService().addUser(user);
  }

  String getEmail() {
    return user.email;
  }

  String getDP() {
    return user.profilePictureLink;
  }
}
