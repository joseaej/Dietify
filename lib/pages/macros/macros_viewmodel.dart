import 'package:Dietify/models/macros.dart';
import 'package:flutter/material.dart';

class MacrosViewmodel extends ChangeNotifier {
  Macros macros = Macros.defaultValues();
  double weather_radius=10;
  /*
  final MacrosRepository _macrosRepository = MacrosRepository();

  List<Macros> _macros = [];
  List<Macros> get macros => _macros;

  void loadMacros() async {
    _macros = await _macrosRepository.getMacros();
    notifyListeners();
  }

  void addMacro(Macros macro) async {
    await _macrosRepository.addMacro(macro);
    loadMacros();
  }

  void deleteMacro(Macros macro) async {
    await _macrosRepository.deleteMacro(macro);
    loadMacros();
  }

  void updateMacro(Macros macro) async {
    await _macrosRepository.updateMacro(macro);
    loadMacros();
  }
  */

  void notify() {
    notifyListeners();
  }

  void addWaterIntake() {
    macros.wheaterIntake += 250;
    weather_radius = (macros.wheaterIntake*100)/2000;
  }

}

class MacrosRepository {
  Future<List<Macros>> getMacros() async {
    return [];
  }

  Future<void> addMacro(Macros macro) async {}

  Future<void> deleteMacro(Macros macro) async {}

  Future<void> updateMacro(Macros macro) async {}
}