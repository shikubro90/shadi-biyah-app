import 'dart:convert';

class PurchesMoreModel {
  int? code;
  String? message;
  Data? data;

  PurchesMoreModel({
    this.code,
    this.message,
    this.data,
  });

  factory PurchesMoreModel.fromRawJson(String str) =>
      PurchesMoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchesMoreModel.fromJson(Map<String, dynamic> json) =>
      PurchesMoreModel(
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
  List<Result>? result;
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
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "country": country,
      };
}

class Result {
  int? pkCountryPrice;
  int? otherCountryPrice;
  int? matchRequests;
  bool? isDeleted;
  String? id;

  Result({
    this.pkCountryPrice,
    this.otherCountryPrice,
    this.matchRequests,
    this.isDeleted,
    this.id,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pkCountryPrice: json["pkCountryPrice"],
        otherCountryPrice: json["otherCountryPrice"],
        matchRequests: json["matchRequests"],
        isDeleted: json["isDeleted"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "pkCountryPrice": pkCountryPrice,
        "otherCountryPrice": otherCountryPrice,
        "matchRequests": matchRequests,
        "isDeleted": isDeleted,
        "id": id,
      };
}
