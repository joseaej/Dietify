import 'package:Dietify/models/macros.dart';
import 'package:Dietify/models/settings.dart';

class UserApp {
  String? password;
  String? email;
  double height = 0.0;
  double weight = 0.0;
  double age = 0.0;
  bool isMale = true;
  Settings settings = Settings();
  Macros macros = Macros.defaultValues();
  UserApp(String? email_, String? password_)
      : email = email_,
        password = password_;
  
  UserApp.withDetails(String? email_, String? password_, double height_, double weight_, double age_)
    : email = email_,
      password = password_,
      height = height_,
      weight = weight_,
      age = age_;
  @override
  bool operator ==(Object other) {
    return (email == (other as UserApp) ? true : false);
  }
}
