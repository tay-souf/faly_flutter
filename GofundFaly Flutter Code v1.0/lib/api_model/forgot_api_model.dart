// To parse this JSON data, do
//
//     final forgotModel = forgotModelFromJson(jsonString);

import 'dart:convert';

ForgotModel forgotModelFromJson(String str) => ForgotModel.fromJson(json.decode(str));

String forgotModelToJson(ForgotModel data) => json.encode(data.toJson());

class ForgotModel {
  String responseCode;
  String result;
  String responseMsg;

  ForgotModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory ForgotModel.fromJson(Map<String, dynamic> json) => ForgotModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}
