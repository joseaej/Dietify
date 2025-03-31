
class Profile  {
  String? email;
  String? username;
  String? urlPhoto;
  double? weight;
  double? height;
  int? age;
  String? activityLevel;
  String? sex;

  Profile({
    this.email,
    this.username,
    this.urlPhoto,
    this.activityLevel,
    this.age,
    this.height,
    this.weight,
    this.sex
  });

  Profile.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        username = map['username'],
        urlPhoto = map['url_photo'],
        sex = map['sex'],
        weight = (map['weight'] as num?)?.toDouble(),
        height = (map['height'] as num?)?.toDouble(),
        age = (map['age'] as num?)?.toInt(),
        activityLevel = map['activity_level'];

  Map<String, dynamic> toMap() {
    return {
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
    String? email,
    String? username,
    String? sex,
    String? urlPhoto,
    double? weight,
    double? height,
    int? age,
    String? activityLevel,
  }) {
    return Profile(
      email: email??this.email,
      username: username ?? this.username,
      sex: sex??this.sex,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

@override
String toString() {
  return 'Profile(email: $email, username: $username, urlPhoto: $urlPhoto, weight: $weight, height: $height, age: $age, activityLevel: $activityLevel, sex: $sex)';
}

}
