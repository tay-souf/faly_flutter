// To parse this JSON data, do
//
//     final fundCompleteApiModel = fundCompleteApiModelFromJson(jsonString);

import 'dart:convert';

FundCompleteApiModel fundCompleteApiModelFromJson(String str) => FundCompleteApiModel.fromJson(json.decode(str));

String fundCompleteApiModelToJson(FundCompleteApiModel data) => json.encode(data.toJson());

class FundCompleteApiModel {
  String responseCode;
  String result;
  String responseMsg;

  FundCompleteApiModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FundCompleteApiModel.fromJson(Map<String, dynamic> json) => FundCompleteApiModel(
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
