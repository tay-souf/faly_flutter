// To parse this JSON data, do
//
//     final walletAddApiModel = walletAddApiModelFromJson(jsonString);

import 'dart:convert';

WalletAddApiModel walletAddApiModelFromJson(String str) => WalletAddApiModel.fromJson(json.decode(str));

String walletAddApiModelToJson(WalletAddApiModel data) => json.encode(data.toJson());

class WalletAddApiModel {
  String wallet;
  String responseCode;
  String result;
  String responseMsg;

  WalletAddApiModel({
    required this.wallet,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory WalletAddApiModel.fromJson(Map<String, dynamic> json) => WalletAddApiModel(
    wallet: json["wallet"],
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}
