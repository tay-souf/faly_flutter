// To parse this JSON data, do
//
//     final searchApiModel = searchApiModelFromJson(jsonString);

import 'dart:convert';

SearchApiModel searchApiModelFromJson(String str) => SearchApiModel.fromJson(json.decode(str));

String searchApiModelToJson(SearchApiModel data) => json.encode(data.toJson());

class SearchApiModel {
  String responseCode;
  String result;
  String responseMsg;
  List<Fundlist> fundlist;

  SearchApiModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.fundlist,
  });

  factory SearchApiModel.fromJson(Map<String, dynamic> json) => SearchApiModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    fundlist: List<Fundlist>.from(json["fundlist"].map((x) => Fundlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "fundlist": List<dynamic>.from(fundlist.map((x) => x.toJson())),
  };
}

class Fundlist {
  String id;
  String catId;
  String title;
  String fundFor;
  List<String> fundPhotos;
  DateTime expDate;
  String fundAmt;
  String fullAddress;
  String lats;
  String longs;
  String fundStory;
  DateTime fundDate;
  List<String> patientPhoto;
  String patientTitle;
  String patientDiagnosis;
  String fundPlan;
  List<String> medicalCertificate;
  String rejectComment;
  String fundStatus;
  String totalInvestment;
  dynamic remainAmt;
  int totalDonaters;
  List<Donaterlist> donaterlist;

  Fundlist({
    required this.id,
    required this.catId,
    required this.title,
    required this.fundFor,
    required this.fundPhotos,
    required this.expDate,
    required this.fundAmt,
    required this.fullAddress,
    required this.lats,
    required this.longs,
    required this.fundStory,
    required this.fundDate,
    required this.patientPhoto,
    required this.patientTitle,
    required this.patientDiagnosis,
    required this.fundPlan,
    required this.medicalCertificate,
    required this.rejectComment,
    required this.fundStatus,
    required this.totalInvestment,
    required this.remainAmt,
    required this.totalDonaters,
    required this.donaterlist,
  });

  factory Fundlist.fromJson(Map<String, dynamic> json) => Fundlist(
    id: json["id"],
    catId: json["cat_id"],
    title: json["title"],
    fundFor: json["fund_for"],
    fundPhotos: List<String>.from(json["fund_photos"].map((x) => x)),
    expDate: DateTime.parse(json["exp_date"]),
    fundAmt: json["fund_amt"],
    fullAddress: json["full_address"],
    lats: json["lats"],
    longs: json["longs"],
    fundStory: json["fund_story"],
    fundDate: DateTime.parse(json["fund_date"]),
    patientPhoto: List<String>.from(json["patient_photo"].map((x) => x)),
    patientTitle: json["patient_title"],
    patientDiagnosis: json["patient_diagnosis"],
    fundPlan: json["fund_plan"],
    medicalCertificate: List<String>.from(json["medical_certificate"].map((x) => x)),
    rejectComment: json["reject_comment"],
    fundStatus: json["fund_status"],
    totalInvestment: json["total_investment"],
    remainAmt: json["remain_amt"],
    totalDonaters: json["total_donaters"],
    donaterlist: List<Donaterlist>.from(json["donaterlist"].map((x) => Donaterlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "title": title,
    "fund_for": fundFor,
    "fund_photos": List<dynamic>.from(fundPhotos.map((x) => x)),
    "exp_date": "${expDate.year.toString().padLeft(4, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.day.toString().padLeft(2, '0')}",
    "fund_amt": fundAmt,
    "full_address": fullAddress,
    "lats": lats,
    "longs": longs,
    "fund_story": fundStory,
    "fund_date": "${fundDate.year.toString().padLeft(4, '0')}-${fundDate.month.toString().padLeft(2, '0')}-${fundDate.day.toString().padLeft(2, '0')}",
    "patient_photo": List<dynamic>.from(patientPhoto.map((x) => x)),
    "patient_title": patientTitle,
    "patient_diagnosis": patientDiagnosis,
    "fund_plan": fundPlan,
    "medical_certificate": List<dynamic>.from(medicalCertificate.map((x) => x)),
    "reject_comment": rejectComment,
    "fund_status": fundStatus,
    "total_investment": totalInvestment,
    "remain_amt": remainAmt,
    "total_donaters": totalDonaters,
    "donaterlist": List<dynamic>.from(donaterlist.map((x) => x.toJson())),
  };
}

class Donaterlist {
  String name;
  String? profilePic;
  String amt;
  String depositeDate;

  Donaterlist({
    required this.name,
    required this.profilePic,
    required this.amt,
    required this.depositeDate,
  });

  factory Donaterlist.fromJson(Map<String, dynamic> json) => Donaterlist(
    name: json["name"],
    profilePic: json["profile_pic"],
    amt: json["amt"],
    depositeDate: json["deposite_date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile_pic": profilePic,
    "amt": amt,
    "deposite_date": depositeDate,
  };
}
