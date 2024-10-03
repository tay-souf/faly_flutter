// To parse this JSON data, do
//
//     final donateNowapi = donateNowapiFromJson(jsonString);

import 'dart:convert';

DonateNowapi donateNowapiFromJson(String str) => DonateNowapi.fromJson(json.decode(str));

String donateNowapiToJson(DonateNowapi data) => json.encode(data.toJson());

class DonateNowapi {
  String responseCode;
  String result;
  String responseMsg;

  DonateNowapi({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory DonateNowapi.fromJson(Map<String, dynamic> json) => DonateNowapi(
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
