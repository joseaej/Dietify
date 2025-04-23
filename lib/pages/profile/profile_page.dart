import 'dart:io';

import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/widgets/vertical_workout_card.dart';
import 'package:dietify/pages/workout/workout_detail_page.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileProvider profileProvider;
  String? _localPhotoPath;

  @override
  void initState() {
    super.initState();
    _loadProfilePhoto();
  }

  Future<void> _loadProfilePhoto() async {
    final savedPath = await SharedPreferenceService.getProfilePhotoPath();
    if (mounted) {
      setState(() {
        _localPhotoPath = savedPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.h),
            CircleAvatar(
              backgroundColor: blue,
              radius: 15.w,
              backgroundImage: _buildProfileImage(),
              child: (_buildProfileImage() == null)
                  ? Icon(Icons.person, size: 40.0, color: Colors.white)
                  : null,
            ),
            SizedBox(height: 2.h),
            Text(
              profileProvider.profile?.username ?? "",
              style: TextStyle(fontSize: 18.sp),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Workout>>(
                future: profileProvider.getAllWorkoutsToProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (snapshot.data == null) {
                    return const Center(
                        child: Text("Error al obtener la lista"));
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("No se encontraron entrenamientos."));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), 
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      childAspectRatio:
                          0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final workout = snapshot.data![index];
                      return VerticalWorkoutCard(
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object>? _buildProfileImage() {
    if (_localPhotoPath != null && File(_localPhotoPath!).existsSync()) {
      return FileImage(File(_localPhotoPath!));
    } else if (profileProvider.profile?.urlPhoto != null &&
        profileProvider.profile!.urlPhoto!.isNotEmpty) {
      return NetworkImage(profileProvider.profile!.urlPhoto!);
    }
    return null;
  }
}
