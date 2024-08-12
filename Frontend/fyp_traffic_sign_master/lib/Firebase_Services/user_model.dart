import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String mobileNum;
  final String password;
  final String? tagline;
  final String? profilepicURL;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.mobileNum,
    required this.password,
    this.tagline,
    this.profilepicURL,
  });

  toJson() {
    return {
      "FullName": fullname,
      "Email": email,
      "Mobile": mobileNum,
      "Password": password,
      "Tagline": tagline,
      "ProfilePicUrl": profilepicURL,
    };
  }

  static UserModel empty() => const UserModel(
        id: '',
        fullname: '',
        email: '',
        mobileNum: '',
        password: '',
        tagline: '',
        profilepicURL: '',
      );

  // Fetching Data from Firestore
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullname: data["FullName"],
      email: data["Email"],
      mobileNum: data["Mobile"],
      password: data["Password"],
      tagline: data["Tagline"] ?? '',
      profilepicURL: data["ProfilePicUrl"] ?? '',
    );
  }
}
