// To parse this JSON data, do
//
//     final fundUpdate = fundUpdateFromJson(jsonString);

import 'dart:convert';

FundUpdate fundUpdateFromJson(String str) => FundUpdate.fromJson(json.decode(str));

String fundUpdateToJson(FundUpdate data) => json.encode(data.toJson());

class FundUpdate {
  String responseCode;
  String result;
  String responseMsg;

  FundUpdate({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FundUpdate.fromJson(Map<String, dynamic> json) => FundUpdate(
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
