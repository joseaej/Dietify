import 'package:dietify/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/repository/profile_repository.dart';

class AuthService with ChangeNotifier {
  Profile? profile;
  Supabase supabase;
  final ProfileRepository _profileRepository = ProfileRepository();
  AuthService({required this.profile, required this.supabase});

  Future<Profile?> signInWithEmailPassword(
      String email, String password) async {
    try {
      AuthResponse reponse = await supabase.client.auth
          .signInWithPassword(email: email, password: password);
      if (reponse.user != null) {
        profile = await _profileRepository.getProfile(email);
        return profile;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Profile?> signUpWithEmailPassword(
      String email, String password, String username) async {
    try {
      AuthResponse reponse =
          await supabase.client.auth.signUp(email: email, password: password);
      if (reponse.user != null) {
        Profile newProfile =
            profile!.copyWith(email: email, username: username);
        _profileRepository.createProfile(newProfile);
        return newProfile;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Profile?> nativeGoogleSignIn() async {
    const webClientId =
        '103862269146-ef9kl2t74hsu116hbqh07ffqcobdsoj6.apps.googleusercontent.com';
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    AuthResponse reponse = await supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (reponse.user != null) {
      Profile newProfile = profile!.copyWith(email: reponse.user!.email, username: reponse.user!.email);
      return newProfile;
    }
    return null;
  }
}
