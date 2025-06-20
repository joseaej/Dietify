import 'dart:io';

import 'package:dietify/domain/providers/achievements_provider.dart';
import 'package:dietify/domain/providers/profile_provider.dart';
import 'package:dietify/domain/providers/settings_provider.dart';
import 'package:dietify/domain/repository/profile_repository.dart';
import 'package:dietify/domain/models/workout.dart';
import 'package:dietify/data/service/auth_service.dart';
import 'package:dietify/data/service/image_service.dart';
import 'package:dietify/data/service/storage_service.dart';
import 'package:dietify/presentation/pages/workout/workout_detail_page.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/presentation/widgets/achivements_item.dart';
import 'package:dietify/presentation/widgets/workout_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileProvider profileProvider;
  late SettingsProvider settings;
  late AchievementsProvider achievementsProvider;
  late StorageService storageService;
  late AuthService authService;
  ProfileRepository repository = ProfileRepository();
  late ImageService imageService;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    storageService = Provider.of<StorageService>(context);
    authService = Provider.of<AuthService>(context);
    settings = Provider.of<SettingsProvider>(context);
    achievementsProvider = Provider.of<AchievementsProvider>(context);
    imageService = Provider.of<ImageService>(context);
    imageService.loadImageFromLocal();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi perfil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 3.h),
            AchivementsItem(
              achievement: achievementsProvider.achievements.where((element) => !element.isAchievementCompleted,).first,
              onTap: () {
                Navigator.pushNamed(context, "/achivements");
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/achivements');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Mostrar más',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              "Mis entrenamientos",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 2.h),
            FutureBuilder<List<Workout>>(
              future: profileProvider.getAllWorkoutsToProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No tienes entrenamientos guardados."),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final workout = snapshot.data![index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: WorkoutCardVertical(
                        workout: workout,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WorkoutDetailPage(workout: workout),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showPhotoOptions(),
          child: CircleAvatar(
            radius: 30.sp,
            backgroundColor: blue,
            backgroundImage: (imageService.photo != null)
                ? FileImage(File(imageService.photo !.path))
                : (profileProvider.profile?.urlPhoto != null &&
                        profileProvider.profile!.urlPhoto!.isNotEmpty)
                    ? NetworkImage(profileProvider.profile!.urlPhoto!)
                        as ImageProvider
                    : null,
            child: (imageService.photo  == null &&
                    (profileProvider.profile?.urlPhoto?.isEmpty ?? true))
                ? const Icon(Icons.camera_alt_rounded,
                    size: 40, color: Color.fromARGB(150, 255, 255, 255))
                : null,
          ),
        ),
        SizedBox(width: 4.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileProvider.profile?.username ?? "Usuario",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              profileProvider.profile?.email ?? "",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
  void _showPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Selecciona una opción',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Cámara'),
              onTap: () => imageService.getImage(ImageSource.camera,profileProvider),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Galería'),
              onTap: () => imageService.getImage(ImageSource.gallery,profileProvider),
            ),
          ],
        ),
      ),
    );
  }
  
}
