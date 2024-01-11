import 'dart:convert';

class InboxModel {
  int? code;
  String? message;
  Data? data;

  InboxModel({
    this.code,
    this.message,
    this.data,
  });

  factory InboxModel.fromRawJson(String str) =>
      InboxModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
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
  List<Datum>? data;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  Attributes({
    this.data,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
      };
}

class Datum {
  Content? content;
  String? id;
  String? chat;
  String? sender;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.content,
    this.id,
    this.chat,
    this.sender,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        id: json["_id"],
        chat: json["chat"],
        sender: json["sender"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "_id": id,
        "chat": chat,
        "sender": sender,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Content {
  String? messageType;
  String? message;

  Content({
    this.messageType,
    this.message,
  });

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        messageType: json["messageType"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "message": message,
      };
}
