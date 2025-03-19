import 'package:dietify/models/profile.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/repository/profile_repository.dart';

class AuthService with ChangeNotifier {
  Profile? profile;
  Supabase supabase;
  final ProfileRepository _profileRepository = ProfileRepository();
  AuthService({required this.profile,required this.supabase});
  

  Future<Profile?> signInWithEmailPassword(String email,String password)async{
    try {
      AuthResponse reponse = await supabase.client.auth.signInWithPassword(email:email, password: password);
      if (reponse.user!=null) {
        profile = await _profileRepository.getProfile(email);
        if (profile!=null) {
          await SharedPreferenceService.setProfileFromLocal(profile!);
        }
        return profile;
      }
      return null;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<Profile?> signUpWithEmailPassword(String email,String password,String username)async{
    try {
      AuthResponse reponse = await supabase.client.auth.signUp(email:email, password: password);
      if (reponse.user!=null) {
        Profile newProfile = profile!.copyWith(email: email,username: username);
        _profileRepository.createProfile(newProfile);
        await SharedPreferenceService.setProfileFromLocal(newProfile);
        return newProfile;
      }
      return null;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
  
}