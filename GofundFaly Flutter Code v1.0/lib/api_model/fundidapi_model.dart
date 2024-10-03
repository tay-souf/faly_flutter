import 'dart:convert';

Fundidimodel fundidimodelFromJson(String str) => Fundidimodel.fromJson(json.decode(str));

String fundidimodelToJson(Fundidimodel data) => json.encode(data.toJson());

class Fundidimodel {
  String responseCode;
  String result;
  String responseMsg;
  List<Funddatum> funddata;
  List<Fundupdate> fundupdate;

  Fundidimodel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.funddata,
    required this.fundupdate,
  });

  factory Fundidimodel.fromJson(Map<String, dynamic> json) => Fundidimodel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    funddata: List<Funddatum>.from(json["funddata"].map((x) => Funddatum.fromJson(x))),
    fundupdate: List<Fundupdate>.from(json["fundupdate"].map((x) => Fundupdate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "funddata": List<dynamic>.from(funddata.map((x) => x.toJson())),
    "fundupdate": List<dynamic>.from(fundupdate.map((x) => x.toJson())),
  };
}

class Funddatum {
  String id;
  String catId;
  String charityName;
  String charityTinno;
  String charityImg;
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
  dynamic rejectComment;
  String fundStatus;
  String totalInvestment;
  String status;
  dynamic remainAmt;
  int totalDonaters;
  List<Donaterlist> donaterlist;

  Funddatum({
    required this.id,
    required this.catId,
    required this.charityName,
    required this.charityTinno,
    required this.charityImg,
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
    required this.status,
  });

  factory Funddatum.fromJson(Map<String, dynamic> json) => Funddatum(
    id: json["id"],
    catId: json["cat_id"],
    charityName: json["charity_name"],
    charityTinno: json["charity_tinno"],
    charityImg: json["charity_img"],
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
    status: json["status"],
    remainAmt: json["remain_amt"],
    totalDonaters: json["total_donaters"],
    donaterlist: List<Donaterlist>.from(json["donaterlist"].map((x) => Donaterlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "charity_name": charityName,
    "charity_tinno": charityTinno,
    "charity_img": charityImg,
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
    "status": status,
    "remain_amt": remainAmt,
    "total_donaters": totalDonaters,
    "donaterlist": List<dynamic>.from(donaterlist.map((x) => x.toJson())),
  };
}

class Donaterlist {
  String? name;
  dynamic profilePic;
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

class Fundupdate {
  String id;
  List<String> photo;
  String updateDesc;
  DateTime updateDate;

  Fundupdate({
    required this.id,
    required this.photo,
    required this.updateDesc,
    required this.updateDate,
  });

  factory Fundupdate.fromJson(Map<String, dynamic> json) => Fundupdate(
    id: json["id"],
    photo: List<String>.from(json["photo"].map((x) => x)),
    updateDesc: json["update_desc"],
    updateDate: DateTime.parse(json["update_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": List<dynamic>.from(photo.map((x) => x)),
    "update_desc": updateDesc,
    "update_date": updateDate.toIso8601String(),
  };
}
