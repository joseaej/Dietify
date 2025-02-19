import 'package:Dietify/models/settings.dart';
import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/settings/settings_page.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  String label;
  String value;
  UserApp user;
  EditPage(
      {super.key,
      required this.label,
      required this.value,
      required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late String label;
  late String value;
  late UserApp user;
  @override
  void initState() {
    label = widget.label;
    value = widget.value;
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(label),
          backgroundColor:
              (user.settings.isDarkMode) ? background : lightBackground,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(
                        user: user,
                      );
                    },
                  ));
                },
                icon: Icon(Icons.check))
          ],
        ),
      ),
    );
  }
}
