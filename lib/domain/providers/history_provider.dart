import 'package:dietify/data/service/shared_preference_service.dart';
import 'package:dietify/domain/models/history_item.dart';
import 'package:flutter/widgets.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryItem> history = List.empty(growable: true);
  HistoryProvider() {
    getHistoryFromLocal();
  }

  void addItemToHistory(HistoryItem item) {
    history.add(item);
    notifyListeners();
  }

  void getHistoryFromLocal() async {
    history = await SharedPreferenceService.loadHistory();
  }

  void saveHistoryFromLocal()async{
    await SharedPreferenceService.saveHistory(history);
  }
}
