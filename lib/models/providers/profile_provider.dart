import 'package:flutter/material.dart';

import '../profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  bool _isLoading = false;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> setProfile(Profile profile) async {
    _isLoading = true;
    notifyListeners(); // Notifica que el estado de carga ha comenzado

    // Simula un delay (por ejemplo, carga desde la base de datos o API)
    await Future.delayed(Duration(seconds: 2));

    _profile = profile;
    _isLoading = false;
    notifyListeners(); // Notifica que el perfil ha sido actualizado y ya no estamos cargando
  }

  void clearProfile() {
    _profile = null;
    notifyListeners(); // Notifica a los widgets cuando se borre el perfil
  }
}

