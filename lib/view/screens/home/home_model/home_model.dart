import 'dart:convert';

class HomeModel {
  int? code;
  String? message;
  Data? data;

  HomeModel({
    this.code,
    this.message,
    this.data,
  });

  factory HomeModel.fromRawJson(String str) =>
      HomeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  bool? isPhoneNumberVerified;
  String? name;
  String? email;
  List<Photo>? photo;
  String? phoneNumber;
  String? role;
  String? oneTimeCode;
  bool? isEmailVerified;
  bool? isDeleted;
  bool? isSuspended;
  String? status;
  bool? payment;
  String? gender;
  String? profileFor;
  String? dataOfBirth;
  double? height;
  String? country;
  String? state;
  String? city;
  String? residentialStatus;
  String? education;
  String? workExperience;
  String? occupation;
  String? income;
  String? annualIncome;
  String? maritalStatus;
  String? motherTongue;
  String? religion;
  String? caste;
  String? sect;
  String? familyStatus;
  String? familyType;
  String? familyValues;
  String? familyIncome;
  String? fathersOccupation;
  String? mothersOccupation;
  String? brothers;
  String? sisters;
  String? habits;
  String? hobbies;
  String? favouriteMusic;
  String? favouriteMovies;
  String? sports;
  String? tvShows;
  String? partnerMinAge;
  String? partnerMixAge;
  String? partnerMinHeight;
  String? partnerMixHeight;
  String? partnerMaritalStatus;
  String? partnerCountry;
  String? partnerCity;
  String? partnerReligion;
  String? partnerResidentialStatus;
  String? partnerEducation;
  String? partnerSect;
  String? partnerCaste;
  String? partnerMotherTongue;
  String? partnerMaxIncome;
  String? partnerMinIncome;
  String? partnerOccupation;
  String? aboutMe;
  bool? isResetPassword;
  int? age;
  String? id;
  String? subscription;

  Result({
    this.isPhoneNumberVerified,
    this.name,
    this.email,
    this.photo,
    this.phoneNumber,
    this.role,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isDeleted,
    this.isSuspended,
    this.status,
    this.payment,
    this.gender,
    this.profileFor,
    this.dataOfBirth,
    this.height,
    this.country,
    this.state,
    this.city,
    this.residentialStatus,
    this.education,
    this.workExperience,
    this.occupation,
    this.income,
    this.annualIncome,
    this.maritalStatus,
    this.motherTongue,
    this.religion,
    this.caste,
    this.sect,
    this.familyStatus,
    this.familyType,
    this.familyValues,
    this.familyIncome,
    this.fathersOccupation,
    this.mothersOccupation,
    this.brothers,
    this.sisters,
    this.habits,
    this.hobbies,
    this.favouriteMusic,
    this.favouriteMovies,
    this.sports,
    this.tvShows,
    this.partnerMinAge,
    this.partnerMixAge,
    this.partnerMinHeight,
    this.partnerMixHeight,
    this.partnerMaritalStatus,
    this.partnerCountry,
    this.partnerCity,
    this.partnerReligion,
    this.partnerResidentialStatus,
    this.partnerEducation,
    this.partnerSect,
    this.partnerCaste,
    this.partnerMotherTongue,
    this.partnerMaxIncome,
    this.partnerMinIncome,
    this.partnerOccupation,
    this.aboutMe,
    this.isResetPassword,
    this.age,
    this.id,
    this.subscription,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPhoneNumberVerified: json["isPhoneNumberVerified"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"] == null
            ? []
            : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        oneTimeCode: json["oneTimeCode"],
        isEmailVerified: json["isEmailVerified"],
        isDeleted: json["isDeleted"],
        isSuspended: json["isSuspended"],
        status: json["status"],
        payment: json["payment"],
        gender: json["gender"],
        profileFor: json["profileFor"],
        dataOfBirth: json["dataOfBirth"],
        height: json["height"]?.toDouble(),
        country: json["country"],
        state: json["state"],
        city: json["city"],
        residentialStatus: json["residentialStatus"],
        education: json["education"],
        workExperience: json["workExperience"],
        occupation: json["occupation"],
        income: json["income"],
        annualIncome: json["annualIncome"],
        maritalStatus: json["maritalStatus"],
        motherTongue: json["motherTongue"],
        religion: json["religion"],
        caste: json["caste"],
        sect: json["sect"],
        familyStatus: json["familyStatus"],
        familyType: json["familyType"],
        familyValues: json["familyValues"],
        familyIncome: json["familyIncome"],
        fathersOccupation: json["fathersOccupation"],
        mothersOccupation: json["mothersOccupation"],
        brothers: json["brothers"],
        sisters: json["sisters"],
        habits: json["habits"],
        hobbies: json["hobbies"],
        favouriteMusic: json["favouriteMusic"],
        favouriteMovies: json["favouriteMovies"],
        sports: json["sports"],
        tvShows: json["tvShows"],
        partnerMinAge: json["partnerMinAge"],
        partnerMixAge: json["partnerMixAge"],
        partnerMinHeight: json["partnerMinHeight"],
        partnerMixHeight: json["partnerMixHeight"],
        partnerMaritalStatus: json["partnerMaritalStatus"],
        partnerCountry: json["partnerCountry"],
        partnerCity: json["partnerCity"],
        partnerReligion: json["partnerReligion"],
        partnerResidentialStatus: json["partnerResidentialStatus"],
        partnerEducation: json["partnerEducation"],
        partnerSect: json["partnerSect"],
        partnerCaste: json["partnerCaste"],
        partnerMotherTongue: json["partnerMotherTongue"],
        partnerMaxIncome: json["partnerMaxIncome"],
        partnerMinIncome: json["partnerMinIncome"],
        partnerOccupation: json["partnerOccupation"],
        aboutMe: json["aboutMe"],
        isResetPassword: json["isResetPassword"],
        age: json["age"],
        id: json["id"],
        subscription: json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "isPhoneNumberVerified": isPhoneNumberVerified,
        "name": name,
        "email": email,
        "photo": photo == null
            ? []
            : List<dynamic>.from(photo!.map((x) => x.toJson())),
        "phoneNumber": phoneNumber,
        "role": role,
        "oneTimeCode": oneTimeCode,
        "isEmailVerified": isEmailVerified,
        "isDeleted": isDeleted,
        "isSuspended": isSuspended,
        "status": status,
        "payment": payment,
        "gender": gender,
        "profileFor": profileFor,
        "dataOfBirth": dataOfBirth,
        "height": height,
        "country": country,
        "state": state,
        "city": city,
        "residentialStatus": residentialStatus,
        "education": education,
        "workExperience": workExperience,
        "occupation": occupation,
        "income": income,
        "annualIncome": annualIncome,
        "maritalStatus": maritalStatus,
        "motherTongue": motherTongue,
        "religion": religion,
        "caste": caste,
        "sect": sect,
        "familyStatus": familyStatus,
        "familyType": familyType,
        "familyValues": familyValues,
        "familyIncome": familyIncome,
        "fathersOccupation": fathersOccupation,
        "mothersOccupation": mothersOccupation,
        "brothers": brothers,
        "sisters": sisters,
        "habits": habits,
        "hobbies": hobbies,
        "favouriteMusic": favouriteMusic,
        "favouriteMovies": favouriteMovies,
        "sports": sports,
        "tvShows": tvShows,
        "partnerMinAge": partnerMinAge,
        "partnerMixAge": partnerMixAge,
        "partnerMinHeight": partnerMinHeight,
        "partnerMixHeight": partnerMixHeight,
        "partnerMaritalStatus": partnerMaritalStatus,
        "partnerCountry": partnerCountry,
        "partnerCity": partnerCity,
        "partnerReligion": partnerReligion,
        "partnerResidentialStatus": partnerResidentialStatus,
        "partnerEducation": partnerEducation,
        "partnerSect": partnerSect,
        "partnerCaste": partnerCaste,
        "partnerMotherTongue": partnerMotherTongue,
        "partnerMaxIncome": partnerMaxIncome,
        "partnerMinIncome": partnerMinIncome,
        "partnerOccupation": partnerOccupation,
        "aboutMe": aboutMe,
        "isResetPassword": isResetPassword,
        "age": age,
        "id": id,
        "subscription": subscription,
      };
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
