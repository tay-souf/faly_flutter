// To parse this JSON data, do
//
//     final faqApiiimodel = faqApiiimodelFromJson(jsonString);

import 'dart:convert';

FaqApiiimodel faqApiiimodelFromJson(String str) => FaqApiiimodel.fromJson(json.decode(str));

String faqApiiimodelToJson(FaqApiiimodel data) => json.encode(data.toJson());

class FaqApiiimodel {
  List<FaqDatum> faqData;
  String responseCode;
  String result;
  String responseMsg;

  FaqApiiimodel({
    required this.faqData,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory FaqApiiimodel.fromJson(Map<String, dynamic> json) => FaqApiiimodel(
    faqData: List<FaqDatum>.from(json["FaqData"].map((x) => FaqDatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "FaqData": List<dynamic>.from(faqData.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class FaqDatum {
  String id;
  String question;
  String answer;
  String status;

  FaqDatum({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
  });

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "status": status,
  };
}
