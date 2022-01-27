class UserModel {
  String? userId;
  String? userName;
  String? profileImg;
  bool? isLookingForJob;
  String? email;
  String? bio;
  String? title;
  String? location;
  String? linkGitHub;
  String? linkStakOverFlow;
  String? linkLinkedIn;
  String? phone;

  UserModel(
      {this.userId,
      this.userName,
      this.profileImg,
      this.isLookingForJob,
      this.email,
      this.bio,
      this.title,
      this.location,
      this.linkGitHub,
      this.linkStakOverFlow,
      this.linkLinkedIn,
      this.phone});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        userName: json["userName"],
        profileImg: json["profileImg"],
        isLookingForJob: json["isLookingForJob"],
        email: json["email"],
        bio: json["bio"],
        title: json["title"],
        location: json["location"],
        linkGitHub: json["linkGitHub"],
        linkStakOverFlow: json["linkStakOverFlow"],
        linkLinkedIn: json["linkLinkedIn"],
        phone: json["phone"],
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
        "linkGitHub": linkGitHub,
        "linkStakOverFlow": linkStakOverFlow,
        "linkLinkedIn": linkLinkedIn,
        "phone": phone,
      };
}
