// To parse this JSON data, do
//
//     final getBalance = getBalanceFromJson(jsonString);

import 'dart:convert';

GetBalance getBalanceFromJson(String str) => GetBalance.fromJson(json.decode(str));

String getBalanceToJson(GetBalance data) => json.encode(data.toJson());

class GetBalance {
  String responseCode;
  String result;
  String responseMsg;
  int totalFund;
  int totalWithdraw;

  GetBalance({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.totalFund,
    required this.totalWithdraw,
  });

  factory GetBalance.fromJson(Map<String, dynamic> json) => GetBalance(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    totalFund: json["Total_Fund"],
    totalWithdraw: json["Total_Withdraw"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "Total_Fund": totalFund,
    "Total_Withdraw": totalWithdraw,
  };
}
