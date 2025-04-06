import 'dart:io';

import 'package:dietify/models/providers/profile_provider.dart';
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
