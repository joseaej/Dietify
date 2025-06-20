import 'package:dietify/domain/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Profile',
    () {
      test('toMap and fromMap', () {
        final profile = Profile(
            email: "test1@gmail.com",
            username: "testUser",
            activityLevel: "ligero",
            age: 30,
            height: 20,
            sex: "Male",
            urlPhoto: "https://photo",
            uuid: "e153185d-9522-4d64-8ac2-2becb545a3d9",
            weight: 90);

        final map = profile.toMap();
        final recreated = Profile.fromMap(map);

        expect(recreated.email, profile.email);
        expect(recreated.username, profile.username);
        expect(recreated.activityLevel, profile.activityLevel);
        expect(recreated.age, profile.age);
        expect(recreated.height, profile.height);
        expect(recreated.sex, profile.sex);
        expect(recreated.uuid, profile.uuid);
        expect(recreated.weight, profile.weight);
        expect(recreated.urlPhoto, profile.urlPhoto);
      });
      test('copyWith', () {
        final profile = Profile(
            email: "test1@gmail.com",
            username: "testUser",
            activityLevel: "ligero",
            age: 30,
            height: 20,
            sex: "Male",
            urlPhoto: "https://photo",
            uuid: "e153185d-9522-4d64-8ac2-2becb545a3d9",
            weight: 90);

        final modified = profile.copyWith(
          email: "test2@gmail.com",
          activityLevel: 'moderado',
        );

        expect(modified.email, "test2@gmail.com");
        expect(modified.activityLevel, 'moderado');
      });
    },
  );
}
