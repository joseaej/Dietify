import 'package:dietify/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/auth/login_page.dart';
import 'service/auth_service.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_LINK']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Profile()),
        ChangeNotifierProxyProvider<Profile, AuthService>(
          create: (context) => AuthService(
            profile: Provider.of<Profile>(context, listen: false),
            supabase: Supabase.instance
          ),
          update: (context, profile, authService) => AuthService(profile: profile, supabase: Supabase.instance),
        ),
      ],
      child: const MainApp(),
    ),
  );
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
