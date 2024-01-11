import 'dart:convert';

class SideMenuModel {
  int? code;
  String? message;
  Data? data;

  SideMenuModel({
    this.code,
    this.message,
    this.data,
  });

  factory SideMenuModel.fromRawJson(String str) =>
      SideMenuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SideMenuModel.fromJson(Map<String, dynamic> json) => SideMenuModel(
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
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attribute({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromRawJson(String str) =>
      Attribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["_id"],
        content: json["content"],
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
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
