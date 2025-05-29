import 'package:dietify/models/settings.dart';
import 'package:dietify/pages/workout/workout_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dietify/models/providers/workout_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'workout_add_test.mocks.dart';

@GenerateMocks([WorkoutProvider, SettingsProvider])
void main() {
  group(
    'Workout Add',
    () {
      late MockWorkoutProvider mockWorkoutProvider;
      late MockSettingsProvider mockSettingsProvider;

      setUp(() {
        mockWorkoutProvider = MockWorkoutProvider();
        mockSettingsProvider = MockSettingsProvider();

        when(mockSettingsProvider.settings).thenReturn(
          Settings.normal(),
        );
      });

      Future<void> pumpWidget(WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<WorkoutProvider>.value(
                  value: mockWorkoutProvider),
              ChangeNotifierProvider<SettingsProvider>.value(
                  value: mockSettingsProvider),
            ],
            child: MaterialApp(
              home: WorkoutAdd(),
            ),
          ),
        );
      }

      testWidgets('test invalid form', (tester) async {
        await pumpWidget(tester);

        final saveButton = find.text('Guardar entrenamiento');
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(find.text('Debes introducir un título'), findsOneWidget);
        expect(find.text('Debes introducir algun musculo'), findsOneWidget);
        expect(find.text('Debes introducir una duracion'), findsOneWidget);
        expect(find.text('Debes introducir las calorias del entrenamiento'),
            findsOneWidget);
        expect(find.text('Selecciona algun tipo de entrenamiento'),
            findsOneWidget);
        expect(find.text('Selecciona la intensidad del entrenamiento'),
            findsOneWidget);
      });
    },
  );
}
