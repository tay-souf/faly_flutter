import 'dart:convert';

CategryWiseFund categryWiseFundFromJson(String str) => CategryWiseFund.fromJson(json.decode(str));

String categryWiseFundToJson(CategryWiseFund data) => json.encode(data.toJson());

class CategryWiseFund {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Catwisefund>? catwisefund;

  CategryWiseFund({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.catwisefund,
  });

  factory CategryWiseFund.fromJson(Map<String, dynamic> json) => CategryWiseFund(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    catwisefund: json["catwisefund"] == null ? [] : List<Catwisefund>.from(json["catwisefund"]!.map((x) => Catwisefund.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "catwisefund": catwisefund == null ? [] : List<dynamic>.from(catwisefund!.map((x) => x.toJson())),
  };
}

class Catwisefund {
  String? id;
  String? catId;
  String? title;
  String? fundFor;
  List<String>? fundPhotos;
  DateTime? expDate;
  String? fundAmt;
  dynamic postcode;
  String? fundStory;
  DateTime? fundDate;
  List<String>? patientPhoto;
  String? patientTitle;
  String? patientDiagnosis;
  String? fundPlan;
  List<String>? medicalCertificate;
  String? rejectComment;
  String? fundStatus;
  String? totalInvestment;
  dynamic remainAmt;
  int? totalDonaters;
  List<Donaterlist>? donaterlist;

  Catwisefund({
    this.id,
    this.catId,
    this.title,
    this.fundFor,
    this.fundPhotos,
    this.expDate,
    this.fundAmt,
    this.postcode,
    this.fundStory,
    this.fundDate,
    this.patientPhoto,
    this.patientTitle,
    this.patientDiagnosis,
    this.fundPlan,
    this.medicalCertificate,
    this.rejectComment,
    this.fundStatus,
    this.totalInvestment,
    this.remainAmt,
    this.totalDonaters,
    this.donaterlist,
  });

  factory Catwisefund.fromJson(Map<String, dynamic> json) => Catwisefund(
    id: json["id"],
    catId: json["cat_id"],
    title: json["title"],
    fundFor: json["fund_for"],
    fundPhotos: json["fund_photos"] == null ? [] : List<String>.from(json["fund_photos"]!.map((x) => x)),
    expDate: json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
    fundAmt: json["fund_amt"],
    postcode: json["postcode"],
    fundStory: json["fund_story"],
    fundDate: json["fund_date"] == null ? null : DateTime.parse(json["fund_date"]),
    patientPhoto: json["patient_photo"] == null ? [] : List<String>.from(json["patient_photo"]!.map((x) => x)),
    patientTitle: json["patient_title"],
    patientDiagnosis: json["patient_diagnosis"],
    fundPlan: json["fund_plan"],
    medicalCertificate: json["medical_certificate"] == null ? [] : List<String>.from(json["medical_certificate"]!.map((x) => x)),
    rejectComment: json["reject_comment"],
    fundStatus: json["fund_status"],
    totalInvestment: json["total_investment"],
    remainAmt: json["remain_amt"],
    totalDonaters: json["total_donaters"],
    donaterlist: json["donaterlist"] == null ? [] : List<Donaterlist>.from(json["donaterlist"]!.map((x) => Donaterlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "title": title,
    "fund_for": fundFor,
    "fund_photos": fundPhotos == null ? [] : List<dynamic>.from(fundPhotos!.map((x) => x)),
    "exp_date": "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
    "fund_amt": fundAmt,
    "postcode": postcode,
    "fund_story": fundStory,
    "fund_date": "${fundDate!.year.toString().padLeft(4, '0')}-${fundDate!.month.toString().padLeft(2, '0')}-${fundDate!.day.toString().padLeft(2, '0')}",
    "patient_photo": patientPhoto == null ? [] : List<dynamic>.from(patientPhoto!.map((x) => x)),
    "patient_title": patientTitle,
    "patient_diagnosis": patientDiagnosis,
    "fund_plan": fundPlan,
    "medical_certificate": medicalCertificate == null ? [] : List<dynamic>.from(medicalCertificate!.map((x) => x)),
    "reject_comment": rejectComment,
    "fund_status": fundStatus,
    "total_investment": totalInvestment,
    "remain_amt": remainAmt,
    "total_donaters": totalDonaters,
    "donaterlist": donaterlist == null ? [] : List<dynamic>.from(donaterlist!.map((x) => x.toJson())),
  };
}

class Donaterlist {
  String? name;
  dynamic profilePic;
  String? amt;
  String? depositeDate;

  Donaterlist({
    this.name,
    this.profilePic,
    this.amt,
    this.depositeDate,
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
