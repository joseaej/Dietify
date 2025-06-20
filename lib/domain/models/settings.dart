class Settings {
  bool isDarkTheme = false;
  bool isNotificationsOn = false;

  Settings(
    this.isDarkTheme,
    this.isNotificationsOn,
  );
  Settings.normal() {
    isDarkTheme = false;
    isNotificationsOn = false;
  }
  Settings.fromMap(Map<String, dynamic> map)
      : isDarkTheme = map['isDarkMode'],
        isNotificationsOn = map['isNotisOn'];

  Map<String, dynamic> toMap() {
    return {
      'isDarkMode': isDarkTheme,
      'isNotisOn': isNotificationsOn,
    };
  }

  Settings copyWith({
    bool? isDarkMode,
    bool? isNotisOn,
  }) {
    return Settings(isDarkMode ?? isDarkTheme, isNotisOn ?? isNotificationsOn);
  }
}
