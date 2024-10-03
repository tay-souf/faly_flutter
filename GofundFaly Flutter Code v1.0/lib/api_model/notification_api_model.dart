// To parse this JSON data, do
//
//     final notificatonListAPiModel = notificatonListAPiModelFromJson(jsonString);

import 'dart:convert';

NotificatonListAPiModel notificatonListAPiModelFromJson(String str) => NotificatonListAPiModel.fromJson(json.decode(str));

String notificatonListAPiModelToJson(NotificatonListAPiModel data) => json.encode(data.toJson());

class NotificatonListAPiModel {
  List<Notificationdatum> notificationdata;
  String responseCode;
  String result;
  String responseMsg;

  NotificatonListAPiModel({
    required this.notificationdata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory NotificatonListAPiModel.fromJson(Map<String, dynamic> json) => NotificatonListAPiModel(
    notificationdata: List<Notificationdatum>.from(json["notificationdata"].map((x) => Notificationdatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "notificationdata": List<dynamic>.from(notificationdata.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Notificationdatum {
  String id;
  String uid;
  DateTime datetime;
  String title;
  String description;

  Notificationdatum({
    required this.id,
    required this.uid,
    required this.datetime,
    required this.title,
    required this.description,
  });

  factory Notificationdatum.fromJson(Map<String, dynamic> json) => Notificationdatum(
    id: json["id"],
    uid: json["uid"],
    datetime: DateTime.parse(json["datetime"]),
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "datetime": datetime.toIso8601String(),
    "title": title,
    "description": description,
  };
}
