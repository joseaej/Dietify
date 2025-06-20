import 'dart:io';

import 'package:dietify/domain/providers/profile_provider.dart';
import 'package:dietify/domain/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'shared_preference_service.dart';
import 'storage_service.dart';

class ImageService with ChangeNotifier{
  XFile? photo; 
  StorageService storageService = StorageService();
  ProfileRepository repository = ProfileRepository();

  
  void getImage(ImageSource source,ProfileProvider profileProvider) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        await saveImageLocally(pickedFile);
        photo = pickedFile;
        notifyListeners();
        final filePath = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final url =
            await storageService.savePhotoToBucket(filePath, File(photo!.path));
        profileProvider.updatePhotoUrl(url);
        repository.updateProfile(profileProvider.profile!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
      notifyListeners();
    }
  }
}
