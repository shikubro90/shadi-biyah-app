import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

class MessageModel {
  List<Datum>? data;
  int? totalPages;
  int? currentPage;
  int? totalChats;

  MessageModel({
    this.data,
    this.totalPages,
    this.currentPage,
    this.totalChats,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        totalChats: json["totalChats"],
      );
}

class Datum {
  Chat? chat;
  Message? message;

  Datum({
    this.chat,
    this.message,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );
}

class Chat {
  List<Participant>? participants;
  String? status;
  String? id;

  Chat({
    this.participants,
    this.status,
    this.id,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        participants: json["participants"] == null
            ? []
            : List<Participant>.from(
                json["participants"]!.map((x) => Participant.fromJson(x))),
        status: json["status"],
        id: json["id"],
      );
}

class Participant {
  String? id;
  String? name;
  List<Photo>? photo;
  String? role;

  Participant({
    this.id,
    this.name,
    this.photo,
    this.role,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        name: json["name"],
        photo: json["photo"] == null
            ? []
            : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
        role: json["role"],
      );
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );
}

class Message {
  Content? content;
  String? id;
  String? chat;
  String? sender;
  String? createdAt;
  String? updatedAt;
  int? v;

  Message({
    this.content,
    this.id,
    this.chat,
    this.sender,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        id: json["id"],
        chat: json["chat"],
        sender: json["sender"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );
}

class Content {
  String? messageType;
  String? message;

  Content({
    this.messageType,
    this.message,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        messageType: json["messageType"],
        message: json["message"],
      );
}
