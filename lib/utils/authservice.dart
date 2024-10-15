import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthService {
  String messageError = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para registrar cuenta
  Future<String?> registerAccount(SignupData data) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: data.name ?? "", password: data.password ?? "");
      return "Cuenta creada con exito";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          messageError = 'El formato del correo es incorrecto.';
          break;
        case 'email-already-in-use':
          messageError = 'Este correo ya está en uso.';
          break;
        case 'weak-password':
          messageError = 'La contraseña es demasiado débil.';
          break;
        case 'operation-not-allowed':
          messageError = 'El tipo de cuenta no está habilitado.';
          break;
        default:
          messageError = 'Ocurrió un error. Código: ${e.code}';
      }
      return messageError;
    }
  }

  // Método para iniciar sesión
  Future<String?> signInAccount(LoginData data) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: data.name, password: data.password);
      return null; 
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          messageError = 'El formato del correo es incorrecto.';
          break;
        case 'user-disabled':
          messageError = 'La cuenta ha sido deshabilitada.';
          break;
        case 'user-not-found':
          messageError = 'No hay ningún usuario con ese correo.';
          break;
        case 'wrong-password':
          messageError = 'La contraseña es incorrecta.';
          break;
        default:
          messageError = 'Ocurrió un error inesperado. Código: ${e.code}';
      }
      return messageError;
    }
  }
}
