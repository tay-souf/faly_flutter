// To parse this JSON data, do
//
//     final mobilcheckModel = mobilcheckModelFromJson(jsonString);

import 'dart:convert';

MobilcheckModel mobilcheckModelFromJson(String str) => MobilcheckModel.fromJson(json.decode(str));

String mobilcheckModelToJson(MobilcheckModel data) => json.encode(data.toJson());

class MobilcheckModel {
  String responseCode;
  String result;
  String responseMsg;

  MobilcheckModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory MobilcheckModel.fromJson(Map<String, dynamic> json) => MobilcheckModel(
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
