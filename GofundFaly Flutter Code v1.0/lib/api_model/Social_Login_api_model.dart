// To parse this JSON data, do
//
//     final socialLoginModel = socialLoginModelFromJson(jsonString);

import 'dart:convert';

SocialLoginModel socialLoginModelFromJson(String str) => SocialLoginModel.fromJson(json.decode(str));

String socialLoginModelToJson(SocialLoginModel data) => json.encode(data.toJson());

class SocialLoginModel {
  UserLogin userLogin;
  String responseCode;
  String result;
  String responseMsg;

  SocialLoginModel({
    required this.userLogin,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) => SocialLoginModel(
    userLogin: UserLogin.fromJson(json["UserLogin"]),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "UserLogin": userLogin.toJson(),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class UserLogin {
  String id;
  String name;
  String mobile;
  String password;
  DateTime rdate;
  String status;
  String ccode;
  String wallet;
  String email;
  dynamic profilePic;

  UserLogin({
    required this.id,
    required this.name,
    required this.mobile,
    required this.password,
    required this.rdate,
    required this.status,
    required this.ccode,
    required this.wallet,
    required this.email,
    required this.profilePic,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    password: json["password"],
    rdate: DateTime.parse(json["rdate"]),
    status: json["status"],
    ccode: json["ccode"],
    wallet: json["wallet"],
    email: json["email"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "password": password,
    "rdate": rdate.toIso8601String(),
    "status": status,
    "ccode": ccode,
    "wallet": wallet,
    "email": email,
    "profile_pic": profilePic,
  };
}
