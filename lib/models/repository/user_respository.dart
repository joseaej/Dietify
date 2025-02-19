import '../goals.dart';
import '../macros.dart';
import '../settings.dart';
import '../user.dart';

class UserRepository {
  final List<UserApp> _users = [
    UserApp.defaultValues(),
    UserApp(
      email: "user1@example.com",
      password: "password1",
      username: "UserOne",
      height: 175,
      weight: 70,
      age: 25,
      isMale: true,
      settings: Settings(isDarkTheme: true, language: 'es'),
      macros: Macros(
        currentCalories: 2000,
        totalCalories: 2500,
        percentage: 80,
        fats: MacroDetail(amount: "70", label: "fats", percentage: "70%"),
        protein: MacroDetail(amount: "90", label: "protein", percentage: "90%"),
        carbs: MacroDetail(amount: "100", label: "carbs", percentage: "100%"),
        wheaterIntake: 3.0,
        goals: Goals(waterGoal: 3.0, sleepGoal: 7),
      ),
    ),
    UserApp(
      email: "user2@example.com",
      password: "password2",
      username: "UserTwo",
      height: 160,
      weight: 55,
      age: 30,
      isMale: false,
      settings: Settings(isDarkTheme: false, language: 'fr'),
      macros: Macros(
        currentCalories: 1800,
        totalCalories: 2200,
        percentage: 82,
        fats: MacroDetail(amount: "60", label: "fats", percentage: "60%"),
        protein: MacroDetail(amount: "85", label: "protein", percentage: "85%"),
        carbs: MacroDetail(amount: "90", label: "carbs", percentage: "90%"),
        wheaterIntake: 2.8,
        goals: Goals(waterGoal: 2.8, sleepGoal: 8),
      ),
    ),
  ];

  List<UserApp> getUsers() {
    return _users;
  }

  UserApp? getUserByEmail(String email) {
    return _users.firstWhere((user) => user.email == email,
        orElse: () => UserApp.defaultValues());
  }

  void addUser(UserApp user) {
    _users.add(user);
  }

  void removeUser(String email) {
    _users.removeWhere((user) => user.email == email);
  }
}
