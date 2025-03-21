
import 'dart:convert';
import 'package:dietify/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _preferences;

  static Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setProfileFromLocal(Profile profile) async {
    await _initPreferences();
    await _preferences?.setString("profile", jsonEncode(profile.toMap()));
  }

  static Future<Profile?> getProfileFromLocal() async {
    await _initPreferences();
    final profileJson = _preferences?.getString("profile");
    if (profileJson == null) return null;
    return Profile.fromMap(jsonDecode(profileJson));
  }

  static Future<void> clearProfile() async {
    await _initPreferences();
    await _preferences?.remove("profile");
  }
}