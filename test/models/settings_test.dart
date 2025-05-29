import 'package:dietify/models/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Settings', () {
    test('Settings constructor', () {
      final settings = Settings(true, false);

      expect(settings.isDarkTheme, isTrue);
      expect(settings.isNotificationsOn, isFalse);
    });

    test('Default values generated to Settings.normal()', () {
      final settings = Settings.normal();

      expect(settings.isDarkTheme, isFalse);
      expect(settings.isNotificationsOn, isFalse);
    });

    test('fromMap', () {
      final map = {
        'isDarkMode': true,
        'isNotisOn': true,
      };

      final settings = Settings.fromMap(map);

      expect(settings.isDarkTheme, isTrue);
      expect(settings.isNotificationsOn, isTrue);
    });

    test('toMap', () {
      final settings = Settings(true, false);

      final map = settings.toMap();

      expect(map['isDarkMode'], isTrue);
      expect(map['isNotisOn'], isFalse);
    });

    test('copyWith', () {
      final original = Settings(false, true);

      final modified = original.copyWith(isDarkMode: true);

      expect(modified.isDarkTheme, isTrue);
      expect(modified.isNotificationsOn, isTrue);

      final modified2 = original.copyWith(isNotisOn: false);

      expect(modified2.isDarkTheme, isFalse);
      expect(modified2.isNotificationsOn, isFalse);
    });
  });
}
