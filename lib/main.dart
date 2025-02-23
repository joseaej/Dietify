import 'package:Dietify/models/macros.dart';
import 'package:Dietify/models/repository/user_respository.dart';
import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/macros/macros_page.dart';
import 'package:Dietify/pages/macros/macros_viewmodel.dart';
import 'package:Dietify/pages/onboard/on_boardcontainer.dart';
import 'package:Dietify/pages/settings/settings_page.dart';
import 'package:Dietify/pages/workout/add_workout_page.dart';
import 'package:Dietify/pages/workout/workout_page.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/settings.dart';
import 'pages/auth/signup_page.dart';
import 'pages/home/home_page.dart';
import 'pages/timer/timer_viewmodel.dart';
import 'services/authservice.dart';
import 'pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['ANON_KEY_SUPABASE']!,
        
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    UserApp? user = UserRepository().getUserByEmail("user1@example.com");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<Macros>(
            create: (context) => Macros.defaultValues()),
        ChangeNotifierProvider<AuthProvider>(
          create: (
            context,
          ) =>
              AuthProvider(),
        ),
        ChangeNotifierProvider<MacrosViewmodel>(
          create: (
            context,
          ) =>
              MacrosViewmodel(),
        ),
        ChangeNotifierProvider<UserApp>(
          create: (
            context,
          ) =>
              UserApp.defaultValues(),
        ),
        ChangeNotifierProvider<TimerViewmodel>(create: (context) => TimerViewmodel(),)
      ],
      child: Sizer(builder: (context, orientation, devicetype) {
        return Consumer<Settings>(
          builder: (context, settings, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Dietify',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              initialRoute: "/macros",
              routes: {
                "/": (context) => AuthHandler(),
                "/login": (context) => LoginScreen(),
                "/signup": (context) => SignupPage(),
                "/onboardcontainer": (context) => OnBoardcontainer(user: user),
                "/home": (context) => HomePage(user: user),
                "/macros": (context) => MacrosPage(
                      user: user,
                    ),
                "/loading": (context) => LoginScreen(),
                "/settings": (context) => SettingsPage(
                      user: user,
                    ),
                "/workout": (context) => WorkoutPage(),
                "/addworkout": (context) => AddWorkoutPage(),
              },
            );
          },
        );
      }),
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
          return MacrosPage(
            user: UserApp.defaultValues(),
          );
        }
        return LoginScreen();
      },
    );
  }
}
