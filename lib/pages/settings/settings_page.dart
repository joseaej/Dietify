// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:Dietify/utils/theme.dart';
import 'package:Dietify/widgets/components/form_rectangular.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/settings.dart';
import '../../models/user.dart';

class SettingsPage extends StatefulWidget {
  UserApp? user;
  SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserApp? user;
  XFile? photo;
  late Settings settings = Provider.of<Settings>(context);
  TextEditingController _username = TextEditingController();
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    settings = Provider.of<Settings>(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: _avatarUI(context),
            ),
            formRectangular(user!.username.toString(), "Username", _username,
                backgroundColor:
                    (settings.isDarkTheme) ? background : lightBackground,
                textColor:
                    (settings.isDarkTheme) ? lightBackground : background),
            _buildSwitch("Activar modo oscuro", settings.isDarkTheme,
                settings.toggleTheme),
            SizedBox(height: 20),
            _buildSwitch("Desactivar notificaciones", settings.allowNotis,
                settings.toggleNotis),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String text, bool value, Function() toggleFunction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        SizedBox(width: 10),
        Switch(
          value: value,
          onChanged: (value) => toggleFunction(),
        ),
      ],
    );
  }

  Widget _avatarUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (context) {
            return selectImagen();
          },
        );
      },
      child: CircleAvatar(
        backgroundColor: Colors.orange,
        radius: 60.0,
        backgroundImage: (photo != null) ? FileImage(File(photo!.path)) : null,
        child: (photo == null)
            ? Icon(Icons.person, size: 80.0, color: Colors.white)
            : null,
      ),
    );
  }

  Widget selectImagen() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.blue),
            title: Text("Galery", style: TextStyle(fontSize: 18.0)),
            onTap: () {
              getImageFromGalery();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.green),
            title: Text("Camera", style: TextStyle(fontSize: 18.0)),
            onTap: () {
              getImageFromCamara();
            },
          ),
        ],
      ),
    );
  }

  Future getImageFromGalery() async {
    photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future getImageFromCamara() async {
    photo = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {});
  }
}
