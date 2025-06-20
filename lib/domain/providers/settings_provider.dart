import 'package:dietify/domain/models/settings.dart';
import 'package:flutter/material.dart';
import '../../data/service/shared_preference_service.dart';

class SettingsProvider with ChangeNotifier {
  Settings? _settings;
  bool _isLoading = false;

  Settings? get settings => _settings;
  bool get isLoading => _isLoading;

  SettingsProvider({Settings? initialSettings}) {
    _settings = initialSettings ?? Settings.normal();
    notifyListeners();
  }

  Future<void> getSavedSettings() async {
    _settings = await SharedPreferenceService.getSettings();
    _settings ??= Settings.normal();
    notifyListeners();
  }

  Future<void> setSettings(Settings settings) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    _settings = settings;
    _isLoading = false;
    notifyListeners();

    // Guardar las configuraciones en SharedPreferences
    await SharedPreferenceService.setSettings(settings);
  }

  void toggleTheme() {
    if (_settings != null) {
      _settings!.isDarkTheme = !_settings!.isDarkTheme;
      notifyListeners();
      setSettings(_settings!);
    }
  }

  void toggleNotis() {
    if (_settings != null) {
      _settings!.isNotificationsOn = !_settings!.isNotificationsOn;
      notifyListeners();
      setSettings(_settings!);
    }
  }

  void setDefaultSettings() {
    _settings = Settings(false, false);
    notifyListeners();
    setSettings(_settings!);
  }
}