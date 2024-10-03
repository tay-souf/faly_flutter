// To parse this JSON data, do
//
//     final editProfileApi = editProfileApiFromJson(jsonString);

import 'dart:convert';

EditProfileApi editProfileApiFromJson(String str) => EditProfileApi.fromJson(json.decode(str));

String editProfileApiToJson(EditProfileApi data) => json.encode(data.toJson());

class EditProfileApi {
  UserLogin userLogin;
  String? currency;
  String responseCode;
  String result;
  String responseMsg;

  EditProfileApi({
    required this.userLogin,
     this.currency,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory EditProfileApi.fromJson(Map<String, dynamic> json) => EditProfileApi(
    userLogin: UserLogin.fromJson(json["UserLogin"]),
    currency: json["currency"] ?? "",
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "UserLogin": userLogin.toJson(),
    "currency": currency,
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
