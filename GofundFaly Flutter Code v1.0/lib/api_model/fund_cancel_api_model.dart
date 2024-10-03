// To parse this JSON data, do
//
//     final fundCancelApi = fundCancelApiFromJson(jsonString);

import 'dart:convert';

FundCancelApi fundCancelApiFromJson(String str) => FundCancelApi.fromJson(json.decode(str));

String fundCancelApiToJson(FundCancelApi data) => json.encode(data.toJson());

class FundCancelApi {
  String responseCode;
  String result;
  String responseMsg;

  FundCancelApi({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FundCancelApi.fromJson(Map<String, dynamic> json) => FundCancelApi(
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
