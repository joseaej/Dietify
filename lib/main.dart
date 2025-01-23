import 'package:Dietify/models/macros.dart';
import 'package:Dietify/pages/macros/macros_page.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<Macros>(create: (context) => Macros.defaultValues()),
      ],
      child:  Consumer<Settings>(
        builder: (context, settings, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dietify',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: MacrosPage(),
          );
        },
      ),
    );
  }
}