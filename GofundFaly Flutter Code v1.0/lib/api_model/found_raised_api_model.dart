// To parse this JSON data, do
//
//     final foundRaisedModel = foundRaisedModelFromJson(jsonString);

import 'dart:convert';

FoundRaisedModel foundRaisedModelFromJson(String str) => FoundRaisedModel.fromJson(json.decode(str));

String foundRaisedModelToJson(FoundRaisedModel data) => json.encode(data.toJson());

class FoundRaisedModel {
  String responseCode;
  String result;
  String responseMsg;

  FoundRaisedModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FoundRaisedModel.fromJson(Map<String, dynamic> json) => FoundRaisedModel(
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
