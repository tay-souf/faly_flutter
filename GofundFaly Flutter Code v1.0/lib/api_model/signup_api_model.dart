import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  UserLogin? userLogin;
  dynamic currency;
  String? responseCode;
  String? result;
  String? responseMsg;

  SignupModel({
    this.userLogin,
    this.currency,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    userLogin: json["UserLogin"] == null ? null : UserLogin.fromJson(json["UserLogin"]),
    currency: json["currency"],
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "UserLogin": userLogin?.toJson(),
    "currency": currency,
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class UserLogin {
  String? id;
  String? name;
  String? mobile;
  String? password;
  DateTime? rdate;
  String? status;
  String? ccode;
  String? wallet;
  String? email;
  dynamic profilePic;

  UserLogin({
    this.id,
    this.name,
    this.mobile,
    this.password,
    this.rdate,
    this.status,
    this.ccode,
    this.wallet,
    this.email,
    this.profilePic,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    password: json["password"],
    rdate: json["rdate"] == null ? null : DateTime.parse(json["rdate"]),
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
    "rdate": rdate?.toIso8601String(),
    "status": status,
    "ccode": ccode,
    "wallet": wallet,
    "email": email,
    "profile_pic": profilePic,
  };
}
