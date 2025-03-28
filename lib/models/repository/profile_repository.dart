import 'package:supabase_flutter/supabase_flutter.dart';

import '../profile.dart';

class ProfileRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Profile?> getProfile(String email) async {
    final response =
        await _supabase.from('profile').select().eq('email', email).single();
    return Profile.fromMap(response);
  }

  Future<void> updateProfile(Profile profile) async {
    final response = await _supabase
        .from('profile')
        .update(profile.toMap())
        .eq('email', profile.email!)
        .select();
    print(response);
  }

  Future<void> deleteProfile(Profile profile) async {
    try {
      await _supabase.from('profile').delete().eq("email", profile.email!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createProfile(Profile profile) async {
    try {
      await _supabase.from('profile').insert(profile.toMap());
    } catch (e) {
      print(e.toString());
    }
  }
}
