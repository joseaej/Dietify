
import 'package:dietify/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _preferences;

  static Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setProfileFromLocal(Profile profile) async {
    await _initPreferences();
    await _preferences?.setString("email", profile.email!);
  }

  static Future<Profile?> getProfileFromLocal() async {
    await _initPreferences();
    final email = _preferences?.getString("email");
    if (email!=null) {
      debugPrint(email);
      return Profile(email: email);
    }
    return null;
  }

  static Future<void> clearProfile() async {
    await _initPreferences();
    
    await _preferences?.remove("email");
  }
}
