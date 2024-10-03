// To parse this JSON data, do
//
//     final accountDeleteApiiimodel = accountDeleteApiiimodelFromJson(jsonString);

import 'dart:convert';

AccountDeleteApiiimodel accountDeleteApiiimodelFromJson(String str) => AccountDeleteApiiimodel.fromJson(json.decode(str));

String accountDeleteApiiimodelToJson(AccountDeleteApiiimodel data) => json.encode(data.toJson());

class AccountDeleteApiiimodel {
  String responseCode;
  String result;
  String responseMsg;

  AccountDeleteApiiimodel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory AccountDeleteApiiimodel.fromJson(Map<String, dynamic> json) => AccountDeleteApiiimodel(
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
