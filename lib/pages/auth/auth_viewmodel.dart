import 'package:Dietify/pages/onboard/on_board3.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/authservice.dart';

class AuthViewmodel {
  static String error = "";
  static Future<bool> registerUser(BuildContext context, String email,
      String password, String username) async {
    final success = await AuthProvider.registerAccount(email, password);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AuthProvider.errorMessage)),
      );
      return false;
    } 
    return true;
  }

  static Future<void> signInUser(
      BuildContext context, String email, String password) async {
    final success = await AuthProvider.signInAccount(email, password);
    if (success) {
      //TODO cambiar navegacion
      await AuthProvider.saveUser(AuthProvider.supabase.auth.currentUser!.id);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardPage3(user: null,)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AuthProvider.errorMessage)),
      );
    }
  }

  static bool validateSignUp(
      String email, String password, String confirmpassword, String username) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty ||
        username.isEmpty) {
      error = "Please fill all the fields";
      return false;
    } else if (password != confirmpassword) {
      error = "Passwords do not match";
      return false;
    } else if (password.length < 6) {
      error = "Password must be at least 6 characters";
      return false;
    } else if (!email.contains(emailRegExp)) {
      error = "Invalid email";
      return false;
    }
    return true;
  }

  static bool validateSignIn(String email, String password) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty || password.isEmpty) {
      error = "Please fill all the fields";
      return false;
    } else if (password.length < 6) {
      error = "Password must be at least 6 characters";
      return false;
    } else if (!email.contains(emailRegExp)) {
      error = "Invalid email";
      return false;
    }
    return true;
  }

  static UserApp? createUser(String email, String password) {
    return UserApp(email, password);
  }
}
