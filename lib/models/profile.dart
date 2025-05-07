import 'package:dietify/models/goal.dart';

class Profile {
  String? uuid;
  String? email;
  String? username;
  String? urlPhoto;
  double? weight;
  double? height;
  int? age;
  String? activityLevel;
  Sex? sex;

  Profile(
      {this.uuid,
      this.email,
      this.username,
      this.urlPhoto,
      this.activityLevel,
      this.age,
      this.height,
      this.weight,
      this.sex});
  Profile.fromMap(Map<String, dynamic> map)
      : uuid = map['id'],
        email = map['email'],
        username = map['username'],
        urlPhoto = map['url_photo'],
        sex = map['sex'],
        weight = (map['weight'] as num?)?.toDouble(),
        height = (map['height'] as num?)?.toDouble(),
        age = (map['age'] as num?)?.toInt(),
        activityLevel = map['activity_level'];

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'email': email,
      'username': username,
      'url_photo': urlPhoto,
      'sex': sex,
      'weight': weight,
      'height': height,
      'age': age,
      'activity_level': activityLevel,
    };
  }

  Profile copyWith({
    String? uuid,
    String? email,
    String? username,
    Sex? sex,
    String? urlPhoto,
    double? weight,
    double? height,
    int? age,
    String? activityLevel,
  }) {
    return Profile(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      username: username ?? this.username,
      sex: sex ?? this.sex,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  @override
  String toString() {
    return 'Profile(id: $uuid,email: $email, username: $username, urlPhoto: $urlPhoto, weight: $weight, height: $height, age: $age, activityLevel: $activityLevel, sex: $sex)';
  }
}
