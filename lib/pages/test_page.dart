import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/service/image_service.dart';
import 'package:dietify/service/recognized_process_ia.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late ProfileProvider profileProvider;
  final ImageService imageService = ImageService();
  final RecognizedProcessIAService recognizedProcessIAService =
      RecognizedProcessIAService();
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _showPhotoOptions();
              },
              child: Icon(Icons.show_chart)),
          TextButton(
              onPressed: () {
                if (imageService.photo != null) {
                  recognizedProcessIAService
                      .processImage(imageService.photo!.path);
                }
              },
              child: Text("Reconocer text"))
        ],
      ),
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
              onTap: () =>
                  imageService.getImage(ImageSource.camera, profileProvider),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Galería'),
              onTap: () =>
                  imageService.getImage(ImageSource.gallery, profileProvider),
            ),
          ],
        ),
      ),
    );
  }
}
