class UserModel {
  String? userId;
  String? userName;
  String? profileImg;
  bool? isLookingForJob;
  String? email;
  String? bio;
  String? title;
  String? location;
  List<dynamic>? socialLink;
  List<dynamic>? contact;

  UserModel(
      {this.userId,
      this.userName,
      this.profileImg,
      this.isLookingForJob,
      this.email,
      this.bio,
      this.title,
      this.location,
      this.socialLink,
      this.contact});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        userName: json["userName"],
        profileImg: json["profileImg"],
        isLookingForJob: json["isLookingForJob"],
        email: json["email"],
        bio: json["bio"],
        title: json["title"],
        location: json["location"],
        socialLink: json["socialLink"],
        contact: json["contact"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "profileImg": profileImg,
        "isLookingForJob": isLookingForJob,
        "email": email,
        "bio": bio,
        "title": title,
        "location": location,
        "socialLink": socialLink,
        "contact": contact
      };
}
