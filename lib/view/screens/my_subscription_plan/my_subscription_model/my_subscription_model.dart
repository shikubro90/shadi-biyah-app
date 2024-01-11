import 'dart:convert';

class MySubscriptionModel {
  int? code;
  String? message;
  Data? data;

  MySubscriptionModel({
    this.code,
    this.message,
    this.data,
  });

  factory MySubscriptionModel.fromRawJson(String str) =>
      MySubscriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) =>
      MySubscriptionModel(
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
  String? userId;
  int? duration;
  String? name;
  int? price;
  int? matchRequests;
  bool? isMatchRequestsNoLimit;
  int? reminders;
  bool? isRemindersNoLimit;
  int? message;
  bool? isMessageNoLimit;
  DateTime? expiryDate;
  SubscriptionId? subscriptionId;
  String? id;

  Attributes({
    this.userId,
    this.duration,
    this.name,
    this.price,
    this.matchRequests,
    this.isMatchRequestsNoLimit,
    this.reminders,
    this.isRemindersNoLimit,
    this.message,
    this.isMessageNoLimit,
    this.expiryDate,
    this.subscriptionId,
    this.id,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        userId: json["userId"],
        duration: json["duration"],
        name: json["name"],
        price: json["price"],
        matchRequests: json["matchRequests"],
        isMatchRequestsNoLimit: json["isMatchRequestsNoLimit"],
        reminders: json["reminders"],
        isRemindersNoLimit: json["isRemindersNoLimit"],
        message: json["message"],
        isMessageNoLimit: json["isMessageNoLimit"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        subscriptionId: json["subscriptionId"] == null
            ? null
            : SubscriptionId.fromJson(json["subscriptionId"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "duration": duration,
        "name": name,
        "price": price,
        "matchRequests": matchRequests,
        "isMatchRequestsNoLimit": isMatchRequestsNoLimit,
        "reminders": reminders,
        "isRemindersNoLimit": isRemindersNoLimit,
        "message": message,
        "isMessageNoLimit": isMessageNoLimit,
        "expiryDate": expiryDate?.toIso8601String(),
        "subscriptionId": subscriptionId?.toJson(),
        "id": id,
      };
}

class SubscriptionId {
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
  bool? subscriptionIdDefault;
  String? id;

  SubscriptionId({
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
    this.subscriptionIdDefault,
    this.id,
  });

  factory SubscriptionId.fromRawJson(String str) =>
      SubscriptionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscriptionId.fromJson(Map<String, dynamic> json) => SubscriptionId(
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
        subscriptionIdDefault: json["default"],
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
        "default": subscriptionIdDefault,
        "id": id,
      };
}
