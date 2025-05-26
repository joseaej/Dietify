import 'dart:io';

import 'package:dietify/models/providers/achievements_provider.dart';
import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/repository/profile_repository.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/storage_service.dart';
import 'package:dietify/pages/workout/workout_detail_page.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/widgets/achivements_item.dart';
import 'package:dietify/widgets/workout_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  XFile? photo;

  @override
  void initState() {
    super.initState();
    loadImageFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    storageService = Provider.of<StorageService>(context);
    authService = Provider.of<AuthService>(context);
    settings = Provider.of<SettingsProvider>(context);
    achievementsProvider = Provider.of<AchievementsProvider>(context);

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
            backgroundImage: (photo != null)
                ? FileImage(File(photo!.path))
                : (profileProvider.profile?.urlPhoto != null &&
                        profileProvider.profile!.urlPhoto!.isNotEmpty)
                    ? NetworkImage(profileProvider.profile!.urlPhoto!)
                        as ImageProvider
                    : null,
            child: (photo == null &&
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
              onTap: () => getImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Galería'),
              onTap: () => getImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        await saveImageLocally(pickedFile);
        setState(() {
          photo = pickedFile;
        });
        final filePath = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final url =
            await storageService.savePhotoToBucket(filePath, File(photo!.path));
        profileProvider.updatePhotoUrl(url);
        repository.updateProfile(profileProvider.profile!);
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {}
  }

  Future<void> saveImageLocally(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile.jpg';
    final localImage = File(path);
    await localImage.writeAsBytes(await image.readAsBytes());
    photo = XFile(localImage.path);
    await SharedPreferenceService.saveProfilePhotoPath(path);
  }

  Future<void> loadImageFromLocal() async {
    final savedPath = await SharedPreferenceService.getProfilePhotoPath();
    if (savedPath != null && File(savedPath).existsSync()) {
      photo = XFile(savedPath);
      setState(() {});
    }
  }
}
