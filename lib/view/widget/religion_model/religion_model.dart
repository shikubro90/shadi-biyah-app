import 'dart:convert';

class ReligionModel {
  int? code;
  String? message;
  Data? data;

  ReligionModel({
    this.code,
    this.message,
    this.data,
  });

  factory ReligionModel.fromRawJson(String str) =>
      ReligionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
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
  List<Religion>? religion;

  Attributes({
    this.religion,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        religion: json["religion"] == null
            ? []
            : List<Religion>.from(
                json["religion"]!.map((x) => Religion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "religion": religion == null
            ? []
            : List<dynamic>.from(religion!.map((x) => x.toJson())),
      };
}

class Religion {
  String? id;
  String? name;
  String? castealias;
  List<Caste>? castes;

  Religion({
    this.id,
    this.name,
    this.castealias,
    this.castes,
  });

  factory Religion.fromRawJson(String str) =>
      Religion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
        id: json["id"],
        name: json["name"],
        castealias: json["castealias"],
        castes: json["castes"] == null
            ? []
            : List<Caste>.from(json["castes"]!.map((x) => Caste.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "castealias": castealias,
        "castes": castes == null
            ? []
            : List<dynamic>.from(castes!.map((x) => x.toJson())),
      };
}

class Caste {
  String? id;
  String? name;

  Caste({
    this.id,
    this.name,
  });

  factory Caste.fromRawJson(String str) => Caste.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Caste.fromJson(Map<String, dynamic> json) => Caste(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
