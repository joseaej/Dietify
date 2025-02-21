
import 'package:Dietify/models/user.dart';
import 'package:flutter/widgets.dart';

class OnBoardViewmodel extends ChangeNotifier {
  UserApp? user;
  static PageController controller = PageController(viewportFraction: 0.8, keepPage: true);
  static String error = "";
  bool validateFields(String height, String weight, String age) {
    try {
      if (height.isEmpty || weight.isEmpty || age.isEmpty) {
        error = "Please fill all the fields";
        return false;
      } else if (double.parse(height) < 0 ||
          double.parse(weight) < 0 ||
          double.parse(age) < 0) {
        return false;
      }
      return true;
    } catch (e) {
      error = "Please enter a number";
      return false;
    }
  }
}
