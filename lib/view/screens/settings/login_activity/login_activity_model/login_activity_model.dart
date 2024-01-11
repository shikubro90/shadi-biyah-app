import 'dart:convert';

class LogInActivityModel {
  int? code;
  String? message;
  Data? data;

  LogInActivityModel({
    this.code,
    this.message,
    this.data,
  });

  factory LogInActivityModel.fromRawJson(String str) =>
      LogInActivityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogInActivityModel.fromJson(Map<String, dynamic> json) =>
      LogInActivityModel(
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
  List<Attribute>? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  String? id;
  String? operatingSystem;
  String? userId;
  String? browser;
  String? ipAddress;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attribute({
    this.id,
    this.operatingSystem,
    this.userId,
    this.browser,
    this.ipAddress,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromRawJson(String str) =>
      Attribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["_id"],
        operatingSystem: json["operatingSystem"],
        userId: json["userId"],
        browser: json["browser"],
        ipAddress: json["ipAddress"],
        location: json["location"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "operatingSystem": operatingSystem,
        "userId": userId,
        "browser": browser,
        "ipAddress": ipAddress,
        "location": location,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
