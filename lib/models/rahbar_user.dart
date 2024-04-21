import 'package:cloud_firestore/cloud_firestore.dart';

class RahbarUser {
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String email;
  late String pushToken;
  late String number;
  late String relationship;
  late String country;
  late String gender;
  late String language;
  late String password;
  late String deviceModel;
  late String deviceVersion;
  late String deviceLocation;
  late String ipAddress;
  late String currentDateTime;



  RahbarUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.number,
    required this.relationship,
    required this.country,
    required this.gender,
    required this.language,
    required this.password,

    required this.deviceModel,
    required this.deviceVersion,
    required this.deviceLocation,
    required this.ipAddress,
    required this.currentDateTime,
  });

  RahbarUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    number = json['number'] ?? '';
    relationship = json['relationship'] ?? '';
    country = json['country'] ?? '';
    gender = json['gender'] ?? '';
    language = json['language'] ?? '';
    password = json['password'] ?? '';
    deviceModel = json['deviceModel'] ?? '';
    deviceVersion = json['deviceVersion'] ?? '';
    deviceLocation = json['deviceLocation'] ?? '';
    ipAddress = json['ipAddress'] ?? '';
    currentDateTime = json['dateAndTime'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['number'] = number;
    data['relationship'] = relationship;
    data['country'] = country;
    data['gender'] = gender;
    data['language'] = language;
    data['deviceModel'] = deviceModel;
    data['deviceVersion'] = deviceVersion;
    data['deviceLocation'] = deviceLocation;
    data['ipAddress'] = ipAddress;
    data['dateAndTime'] = currentDateTime;

    return data;
  }
}
