import 'dart:convert';

ActivityModel activityModelFromJson(String str) => ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
  String responseCode;
  String result;
  String responseMsg;
  List<Activitylist> activitylist;

  ActivityModel({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.activitylist,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    activitylist: List<Activitylist>.from(json["activitylist"].map((x) => Activitylist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "activitylist": List<dynamic>.from(activitylist.map((x) => x.toJson())),
  };
}

class Activitylist {
  dynamic donatorId;
  String fundTitle;
  dynamic profilePic;
  String donationAmt;
  String name;

  Activitylist({
    required this.donatorId,
    required this.fundTitle,
    required this.profilePic,
    required this.donationAmt,
    required this.name,
  });

  factory Activitylist.fromJson(Map<String, dynamic> json) => Activitylist(
    donatorId: json["donator_id"],
    fundTitle: json["fund_title"],
    profilePic: json["profile_pic"],
    donationAmt: json["donation_amt"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "donator_id": donatorId,
    "fund_title": fundTitle,
    "profile_pic": profilePic,
    "donation_amt": donationAmt,
    "name": name,
  };
}
