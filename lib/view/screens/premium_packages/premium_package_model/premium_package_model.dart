import 'dart:convert';

class PremiumPackageModel {
  int? code;
  String? message;
  Data? data;

  PremiumPackageModel({
    this.code,
    this.message,
    this.data,
  });

  factory PremiumPackageModel.fromRawJson(String str) =>
      PremiumPackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PremiumPackageModel.fromJson(Map<String, dynamic> json) =>
      PremiumPackageModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Attributes? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
      };
}

class Attributes {
  AttributesResult? result;
  String? country;

  Attributes({
    this.result,
    this.country,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        result: json["result"] == null
            ? null
            : AttributesResult.fromJson(json["result"]),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "country": country,
      };
}

class AttributesResult {
  List<ResultElement>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  AttributesResult({
    this.results,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  factory AttributesResult.fromRawJson(String str) =>
      AttributesResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttributesResult.fromJson(Map<String, dynamic> json) =>
      AttributesResult(
        results: json["results"] == null
            ? []
            : List<ResultElement>.from(
                json["results"]!.map((x) => ResultElement.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
      };
}

class ResultElement {
  String? name;
  int? pkCountryPrice;
  int? otherCountryPrice;
  int? duration;
  int? matchRequests;
  bool? isMatchRequestsNoLimit;
  int? reminders;
  bool? isRemindersNoLimit;
  int? message;
  bool? isMessageNoLimit;
  bool? isPremiumBadge;
  bool? isDeleted;
  bool? resultDefault;
  String? id;

  ResultElement({
    this.name,
    this.pkCountryPrice,
    this.otherCountryPrice,
    this.duration,
    this.matchRequests,
    this.isMatchRequestsNoLimit,
    this.reminders,
    this.isRemindersNoLimit,
    this.message,
    this.isMessageNoLimit,
    this.isPremiumBadge,
    this.isDeleted,
    this.resultDefault,
    this.id,
  });

  factory ResultElement.fromRawJson(String str) =>
      ResultElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
        name: json["name"],
        pkCountryPrice: json["pkCountryPrice"],
        otherCountryPrice: json["otherCountryPrice"],
        duration: json["duration"],
        matchRequests: json["matchRequests"],
        isMatchRequestsNoLimit: json["isMatchRequestsNoLimit"],
        reminders: json["reminders"],
        isRemindersNoLimit: json["isRemindersNoLimit"],
        message: json["message"],
        isMessageNoLimit: json["isMessageNoLimit"],
        isPremiumBadge: json["isPremiumBadge"],
        isDeleted: json["isDeleted"],
        resultDefault: json["default"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pkCountryPrice": pkCountryPrice,
        "otherCountryPrice": otherCountryPrice,
        "duration": duration,
        "matchRequests": matchRequests,
        "isMatchRequestsNoLimit": isMatchRequestsNoLimit,
        "reminders": reminders,
        "isRemindersNoLimit": isRemindersNoLimit,
        "message": message,
        "isMessageNoLimit": isMessageNoLimit,
        "isPremiumBadge": isPremiumBadge,
        "isDeleted": isDeleted,
        "default": resultDefault,
        "id": id,
      };
}
