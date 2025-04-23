import 'dart:io';

import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/repository/profile_repository.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/service/storage_service.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  late StorageService storageService;
  late AuthService authService;
  final TextEditingController _usernameController = TextEditingController();
  ProfileRepository repository = ProfileRepository();

  @override
  void initState() {
    loadImageFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    storageService = Provider.of<StorageService>(context);
    authService = Provider.of<AuthService>(context);
    settings = Provider.of<SettingsProvider>(context);
    _usernameController.text = profileProvider.profile?.username ?? '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              icon: Icon(Icons.abc))
        ],
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
              () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Selecciona una opcion',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            leading: const Icon(Icons.camera_alt,
                                color: Colors.blue),
                            title: const Text('Cámara'),
                            onTap: () {
                              getImageFromCamara();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library,
                                color: Colors.green),
                            title: const Text('Galería'),
                            onTap: () {
                              getImageFromGalery();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
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
              icon: Icons.dark_mode,
              title: 'Notificaciones',
              trailing: Switch(
                value: settings.settings!.isNotificationsOn,
                onChanged: (p0) {
                  setState(() {
                    settings.toggleNotis();
                  });
                },
              ),
            ),
            SizedBox(height: 4.h),
            _buildSectionTitle('Cuenta'),
            _buildSettingOption(
              icon: Icons.email,
              title: 'Cambiar email',
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
            ),
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
                Navigator.pushReplacementNamed(context, "/login");
                profileProvider.clearProfile();
                SharedPreferenceService.clearProfile();
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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      saveImageLocally(pickedFile);
      setState(() {
        photo = pickedFile;
      });
      String filePath = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
      String path =
          await storageService.savePhotoToBucket(filePath, File(photo!.path));
      profileProvider.updatePhotoUrl(path);
      repository.updateProfile(profileProvider.profile!);
    }
  }

  Future getImageFromCamara() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      saveImageLocally(pickedFile);
      setState(() {
        photo = pickedFile;
      });
      String filePath = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
      String path =
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
    setState(() {
      photo = XFile(localImage.path);
    });

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
