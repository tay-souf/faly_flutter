// To parse this JSON data, do
//
//     final smaApiModel = smaApiModelFromJson(jsonString);

import 'dart:convert';

SmaApiModel smaApiModelFromJson(String str) => SmaApiModel.fromJson(json.decode(str));

String smaApiModelToJson(SmaApiModel data) => json.encode(data.toJson());

class SmaApiModel {
  String responseCode;
  String result;
  String responseMsg;
  String smsType;

  SmaApiModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.smsType,
  });

  factory SmaApiModel.fromJson(Map<String, dynamic> json) => SmaApiModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    smsType: json["SMS_TYPE"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "SMS_TYPE": smsType,
  };
}
