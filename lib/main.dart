import 'package:Dietify/models/macros.dart';
import 'package:Dietify/pages/auth/signup_page.dart';
import 'package:Dietify/pages/macros/macros_page.dart';
import 'package:Dietify/pages/onboard/on_board1.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/settings.dart';
import 'services/authservice.dart';
import 'pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jjaoxdfxgqmzxovrgbog.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqYW94ZGZ4Z3FtenhvdnJnYm9nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc2NDczMjYsImV4cCI6MjA1MzIyMzMyNn0.sSzeJDPpeNgN73tGzdOe5_5nOGoj5FZaBFMBH5cOE-c',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<Macros>(
            create: (context) => Macros.defaultValues()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context,) => AuthProvider(),),
      ],
      child: Consumer<Settings>(
        builder: (context, settings, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dietify',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: "/onboard1",
            routes: {
              "/login": (context) => LoginScreen(),
              "/signup": (context) => SignupPage(),
              "/onboard1": (context) => OnBoardPage1(user: null,),
              "/home": (context) => MacrosPage(),
              "/macros": (context) => MacrosPage(),
              "/loading": (context) => LoginScreen(),
            },
          );
        },
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  static String route = "/login";
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder<String?>(
      future: authProvider.checkUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          route = "/loading";
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data != null) {
          route = "/home";
          return MacrosPage();
        }
        return LoginScreen();
      },
    );
  }
}
