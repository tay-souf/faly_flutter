// To parse this JSON data, do
//
//     final pageListApiiimodel = pageListApiiimodelFromJson(jsonString);

import 'dart:convert';

PageListApiiimodel pageListApiiimodelFromJson(String str) => PageListApiiimodel.fromJson(json.decode(str));

String pageListApiiimodelToJson(PageListApiiimodel data) => json.encode(data.toJson());

class PageListApiiimodel {
  List<Pagelist> pagelist;
  String responseCode;
  String result;
  String responseMsg;

  PageListApiiimodel({
    required this.pagelist,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory PageListApiiimodel.fromJson(Map<String, dynamic> json) => PageListApiiimodel(
    pagelist: List<Pagelist>.from(json["pagelist"].map((x) => Pagelist.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "pagelist": List<dynamic>.from(pagelist.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Pagelist {
  String title;
  String description;

  Pagelist({
    required this.title,
    required this.description,
  });

  factory Pagelist.fromJson(Map<String, dynamic> json) => Pagelist(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}
