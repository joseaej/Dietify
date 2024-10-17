import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  Future<User?> registerAccount(String email,String password) async{
    try {
      UserCredential userCredential = await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> singInAccount(String email,String password) async{
    try {
      UserCredential userCredential = await _authInstance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

}
