class User {
  String userID = '';

  String email = '';

  String profilePictureLink = "";

  User({
    required this.email,
    this.userID = '',
    this.profilePictureLink = '',
  });
  User.defaultValue() {
    email = '';

    userID = '';
    profilePictureLink = "";
  }
  User.fromJSon(Map<String, dynamic> json) {
    userID = json['userID'];

    email = json['email'];

    profilePictureLink = json['profilePictureLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userID'] = userID;
    data['email'] = email;
    data['profilePictureLink'] = profilePictureLink;
    return data;
  }
}
