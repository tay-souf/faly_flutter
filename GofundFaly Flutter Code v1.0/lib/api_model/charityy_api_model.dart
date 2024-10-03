// To parse this JSON data, do
//
//     final charityyApi = charityyApiFromJson(jsonString);

import 'dart:convert';

CharityyApi charityyApiFromJson(String str) => CharityyApi.fromJson(json.decode(str));

String charityyApiToJson(CharityyApi data) => json.encode(data.toJson());

class CharityyApi {
  List<Charitydatum> charitydata;
  String responseCode;
  String result;
  String responseMsg;

  CharityyApi({
    required this.charitydata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory CharityyApi.fromJson(Map<String, dynamic> json) => CharityyApi(
    charitydata: List<Charitydatum>.from(json["charitydata"].map((x) => Charitydatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "charitydata": List<dynamic>.from(charitydata.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Charitydatum {
  String id;
  String title;
  String tinNo;
  String status;
  String charityImg;

  Charitydatum({
    required this.id,
    required this.title,
    required this.tinNo,
    required this.status,
    required this.charityImg,
  });

  factory Charitydatum.fromJson(Map<String, dynamic> json) => Charitydatum(
    id: json["id"],
    title: json["title"],
    tinNo: json["tin_no"],
    status: json["status"],
    charityImg: json["charity_img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "tin_no": tinNo,
    "status": status,
    "charity_img": charityImg,
  };
}
