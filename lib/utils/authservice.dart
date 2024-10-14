import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  String messageError="";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerAccount(String email,String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return (user.user?.uid);
    }on FirebaseAuthException catch (e) {
      messageError = e.code;
    }
  }
  Future singInAccount(String email,String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final comprobator = user.user;
      if (comprobator?.uid!=null) {
        return comprobator?.uid;
      }
      return (user.user?.uid);
    }on FirebaseAuthException catch (e) {
      messageError = e.code;
    }
  }
}