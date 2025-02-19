
import 'package:Dietify/models/macros.dart';
import 'package:Dietify/models/settings.dart';

class UserApp {
  String? password;
  String? username;
  String? email;
  double height;
  double weight;
  double age;
  bool isMale;
  Settings settings;
  Macros macros;

  UserApp({
    this.email,
    this.password,
    this.username,
    this.height = 0.0,
    this.weight = 0.0,
    this.age = 0.0,
    this.isMale = true,
    Settings? settings,
    Macros? macros,
  })  : settings = settings ?? Settings(),
        macros = macros ?? Macros.defaultValues();

   UserApp.defaultValues()
      : email = "prueba@gmail.com",
        password = "1234",
        height = 30,
        weight = 90,
        age = 20,
        isMale = true,
        settings = Settings(),
        macros = Macros.defaultValues();

  @override
  bool operator ==(Object other) {
    return (email == (other as UserApp) ? true : false);
  }
}
