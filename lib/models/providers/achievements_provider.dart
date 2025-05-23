import 'package:dietify/models/achievements.dart';
import 'package:flutter/material.dart';


class AchievementsProvider with ChangeNotifier {
  List<Achievements> achievements = List.empty(growable: true);

  void updateAchivementProcess(Achievements achivement){
    if (achievements.contains(achivement)) {
      int index = achievements.indexOf(achivement);
      achievements.replaceRange(index, index, achivement as Iterable<Achievements>);
      notifyListeners();
    }
  }
}
