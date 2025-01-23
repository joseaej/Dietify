import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 late Settings settings = Provider.of<Settings>(context);
  @override
  Widget build(BuildContext context) {
    settings = Provider.of<Settings>(context);
    return Scaffold(
      body: _body,
    );
  }

  Center get _body => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Activar modo oscuro"),
                ),
                Switch(value: settings.isDarkTheme, onChanged: (value) => settings.toggleTheme(),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Desactivar notificaciones"),
                ),
                Switch(value: settings.allowNotis, onChanged: (value) => settings.toggleNotis(),)
              ],
            )
          ],
        ),
      );
}
