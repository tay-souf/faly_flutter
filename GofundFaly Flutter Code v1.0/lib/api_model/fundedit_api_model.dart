// To parse this JSON data, do
//
//     final fundEditmodel = fundEditmodelFromJson(jsonString);

import 'dart:convert';

FundEditmodel fundEditmodelFromJson(String str) => FundEditmodel.fromJson(json.decode(str));

String fundEditmodelToJson(FundEditmodel data) => json.encode(data.toJson());

class FundEditmodel {
  String responseCode;
  String result;
  String responseMsg;

  FundEditmodel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FundEditmodel.fromJson(Map<String, dynamic> json) => FundEditmodel(
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
