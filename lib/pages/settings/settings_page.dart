import 'dart:io';

import 'package:dietify/models/providers/goal_provider.dart';
import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/repository/profile_repository.dart';
import 'package:dietify/pages/settings/terms_and_services.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/service/storage_service.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  XFile? photo;
  late SettingsProvider settings;
  late ProfileProvider profileProvider;
  late GoalProvider goalProvider;
  late StorageService storageService;
  late AuthService authService;
  final TextEditingController _usernameController = TextEditingController();
  ProfileRepository repository = ProfileRepository();
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    loadImageFromLocal();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationsEnabled = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    goalProvider = Provider.of<GoalProvider>(context);
    storageService = Provider.of<StorageService>(context);
    authService = Provider.of<AuthService>(context);
    settings = Provider.of<SettingsProvider>(context);
    _usernameController.text = profileProvider.profile?.username ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: blue,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(
              () {},
            ),
            SizedBox(height: 4.h),
            _buildSectionTitle('General'),
            _buildSettingOption(
              icon: Icons.dark_mode,
              title: 'Modo oscuro',
              trailing: Switch(
                focusColor: blue,
                value: settings.settings!.isDarkTheme,
                onChanged: (p0) {
                  setState(() {
                    settings.toggleTheme();
                  });
                },
              ),
            ),
            _buildSettingOption(
              icon: Icons.notifications,
              title: 'Notificaciones',
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (enabled) async {
                  if (enabled) {
                    final status = await Permission.notification.request();
                    setState(() {
                      _notificationsEnabled = status.isGranted;
                    });
                  } else {
                    openAppSettings();
                  }
                },
              ),
            ),
            SizedBox(height: 4.h),
            _buildSectionTitle('Cuenta'),
            _buildSettingOption(
              icon: Icons.lock,
              title: 'Cambiar contraseña',
              onTap: () {
                if (profileProvider.profile != null) {
                  authService
                      .changePasswordForEmail(profileProvider.profile!.email!);
                }
              },
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
            ),
            _buildSettingOption(
              icon: Icons.close,
              title: 'Cerrar cuenta',
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              isDestructive: true,
              onTap: () {
                settings.setDefaultSettings();
                SharedPreferenceService.clearSettings();
                profileProvider.clearProfile();
                SharedPreferenceService.clearProfile();
                goalProvider.clearGoals();
                SharedPreferenceService.clearGoals();
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
            _buildSettingOption(
              icon: Icons.delete,
              title: 'Eliminar cuenta',
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              isDestructive: true,
              onTap: () {
                settings.setDefaultSettings();
                SharedPreferenceService.clearSettings();
                Navigator.pushReplacementNamed(context, "/login");
                ProfileRepository().deleteProfile(profileProvider.profile!);
              },
            ),
            _buildSectionTitle('Soporte'),
            _buildSettingOption(
              icon: Icons.lock,
              title: 'Terminos y servicios',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage(),
                    ));
              },
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(Function() onTap) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: (settings.settings!.isDarkTheme) ? backgroundTextField : font,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 8.w,
              backgroundColor: skyBlue,
              backgroundImage:
                  (photo != null) ? FileImage(File(photo!.path)) : null,
              child: (photo == null)
                  ? Icon(Icons.person, size: 40.0, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (profileProvider.profile != null)
                    ? profileProvider.profile!.username!
                    : "",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                (profileProvider.profile != null)
                    ? profileProvider.profile!.email!
                    : "",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: blue,
        ),
      ),
    );
  }

  Widget _buildSettingOption(
      {required IconData icon,
      required String title,
      required Widget trailing,
      bool isDestructive = false,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: (settings.settings!.isDarkTheme) ? backgroundTextField : font,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : blue),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                      ? Colors.red
                      : (settings.settings!.isDarkTheme)
                          ? font
                          : darkfont,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Future getImageFromGalery() async {
    await _handleImageSelection(ImageSource.gallery);
  }

  Future getImageFromCamara() async {
    await _handleImageSelection(ImageSource.camera);
  }

  Future<void> _handleImageSelection(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      await saveImageLocally(pickedFile);
      setState(() {
        photo = XFile(pickedFile.path);
      });
      final filePath = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path =
          await storageService.savePhotoToBucket(filePath, File(photo!.path));
      profileProvider.updatePhotoUrl(path);
      repository.updateProfile(profileProvider.profile!);
    }
  }

  Future<void> saveImageLocally(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/profile.jpg';
    final File localImage = File(filePath);
    await localImage.writeAsBytes(await image.readAsBytes());
    photo = XFile(localImage.path);
    await SharedPreferenceService.saveProfilePhotoPath(localImage.path);
  }

  Future<void> loadImageFromLocal() async {
    final savedPath = await SharedPreferenceService.getProfilePhotoPath();
    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        photo = XFile(savedPath);
      });
    }
  }
}
