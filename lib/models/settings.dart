import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  bool isDarkTheme;
  bool isNotisON;
  String language;

  // Constructor con valores predeterminados
  Settings({this.isDarkTheme = false, this.language = 'en',this.isNotisON = true});


  bool get isDarkMode => isDarkTheme;
  bool get allowNotis => isNotisON;

  // Método para alternar el tema (oscuro/claro)
  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  // Método para alternar las notificaciones
  void toggleNotis() {
    isNotisON = !isNotisON;
    notifyListeners();
  }

  // Método para establecer un nuevo idioma
  void setLanguage(String newLanguage) {
    language = newLanguage;
  }

  // Método para reiniciar la configuración a valores predeterminados
  void reset() {
    isDarkTheme = false;
    language = 'en';
  }

  Map<String, dynamic> toMap() {
    return {
      'isDarkTheme': isDarkTheme,
      'language': language,
      'isNotisOn': isNotisON
    };
  }

  // Método para cargar configuración desde un mapa
  void loadFromMap(Map<String, dynamic> map) {
    isDarkTheme = map['isDarkTheme'] ?? isDarkTheme;
    language = map['language'] ?? language;
    isNotisON = map['isNotisOn'] ?? isNotisON;
  }
}
