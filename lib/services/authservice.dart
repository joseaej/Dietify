import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  String errorMessage = "";

  // Registro de usuario
  Future<bool> registerAccount(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        await saveUser(response.user!.id);
        return true;
      }
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  // Inicio de sesión
  Future<bool> signInAccount(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);
      if (response.user != null) {
        await saveUser(response.user!.id);
        return true;
      }
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  // Guardar el usuario en SharedPreferences
  Future<void> saveUser(String userId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('uid', userId);
  }

  // Verificar si hay un usuario autenticado
 Future<String?> checkUser() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('uid');
  }

  // Cerrar sesión
  Future<void> closeSession() async {
    try {
      await supabase.auth.signOut();
      final pref = await SharedPreferences.getInstance();
      await pref.remove('uid');
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
