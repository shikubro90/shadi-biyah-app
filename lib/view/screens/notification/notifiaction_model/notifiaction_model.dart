import 'dart:convert';

class NotificationModel {
  int? code;
  String? message;
  Data? data;

  NotificationModel({
    this.code,
    this.message,
    this.data,
  });

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
  List<Result>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  Attributes({
    this.results,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
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

class Result {
  String? id;
  String? receiverId;
  String? message;
  List<Image>? image;
  String? linkId;
  String? role;
  String? type;
  bool? viewStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Result({
    this.id,
    this.receiverId,
    this.message,
    this.image,
    this.linkId,
    this.role,
    this.type,
    this.viewStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        receiverId: json["receiverId"],
        message: json["message"],
        image: json["image"] == null
            ? []
            : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),
        linkId: json["linkId"],
        role: json["role"],
        type: json["type"],
        viewStatus: json["viewStatus"],
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
        "receiverId": receiverId,
        "message": message,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
        "linkId": linkId,
        "role": role,
        "type": type,
        "viewStatus": viewStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
