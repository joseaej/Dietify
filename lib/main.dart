import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login_page.dart';
import 'utils/theme.dart';

Future<void> main() async {
  
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_LINK']!, 
    anonKey: dotenv.env['SUPABASE_KEY']!
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LoginScreen(),
    );
  }
}
