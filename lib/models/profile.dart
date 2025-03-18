import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  String? email;
  String? username;
  String? urlPhoto;
  double? weight;
  double? height;
  int? age;
  String? activityLevel;

  Profile({
    this.email,
    this.username,
    this.urlPhoto,
    this.activityLevel,
    this.age,
    this.height,
    this.weight,
  });

  Profile.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        username = map['username'],
        urlPhoto = map['url_photo'],
        weight = (map['weight'] as num?)?.toDouble(),
        height = (map['height'] as num?)?.toDouble(),
        age = map['age'],
        activityLevel = map['activity_level'];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'url_photo': urlPhoto,
      'weight': weight,
      'height': height,
      'age': age,
      'activity_level': activityLevel,
    };
  }

  Profile copyWith({
    String? email,
    String? username,
    String? urlPhoto,
    double? weight,
    double? height,
    int? age,
    String? activityLevel,
  }) {
    return Profile(
      email: email,
      username: username ?? this.username,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  void updateProfile({
    String? user,
    String? urlPhoto,
    double? weight,
    double? height,
    int? age,
    String? activityLevel,
  }) {
    username = user ?? username;
    this.urlPhoto = urlPhoto ?? this.urlPhoto;
    this.weight = weight ?? this.weight;
    this.height = height ?? this.height;
    this.age = age ?? this.age;
    this.activityLevel = activityLevel ?? this.activityLevel;

    notifyListeners();
  }
}
