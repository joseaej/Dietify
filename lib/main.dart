import 'package:dietify/models/providers/goal_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/pages/auth/sign_up_page.dart';
import 'package:dietify/pages/home/home_container.dart';
import 'package:dietify/pages/settings/settings_page.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/service/storage_service.dart';
import 'package:dietify/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/profile.dart';
import 'models/providers/profile_provider.dart';
import 'models/settings.dart';
import 'pages/auth/login_page.dart';
import 'pages/onboarding/onboarding_page.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_LINK'] ?? '',
    anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
  );

  final String route =
      await SharedPreferenceService.getProfileFromLocal() != null
          ? "/home"
          : "/login";

  final Settings? settings = await SharedPreferenceService.getSettings();

  runApp(MainApp(route: route, initialSettings: settings));
}

class MainApp extends StatelessWidget {
  final String route;
  final Settings? initialSettings;

  const MainApp({super.key, required this.route, this.initialSettings});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => GoalProvider()),
        ChangeNotifierProvider(create: (context) => StorageService()),
        ChangeNotifierProvider(
            create: (context) =>
                SettingsProvider(initialSettings: initialSettings)),
        ChangeNotifierProvider(
          create: (context) => AuthService(
            profile: Profile(email: "", username: ""),
            supabase: Supabase.instance,
          ),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          // Detectar cuando la app se cierra
          GoalProvider goalsProvider = GoalProvider();
          SystemChannels.lifecycle.setMessageHandler((msg) async {
            if (msg == AppLifecycleState.detached.toString()) {
              await SharedPreferenceService.setGoalsFromLocal(
                  goalsProvider.goal!);
            }
            return null;
          });
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Dietify',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: settingsProvider.settings?.isDarkTheme ?? false
                    ? ThemeMode.dark
                    : ThemeMode.light,
                initialRoute: route,
                routes: {
                  '/home': (context) => HomeContainer(),
                  '/login': (context) => LoginScreen(),
                  '/signup': (context) => SignupPage(),
                  '/onboarding': (context) => OnboardingPage(),
                  '/settings': (context) => SettingsPage(),
                  "/spash":(context) => SplashScreen(route: "/login",seconds: 4,)
                },
              );
            },
          );
        },
      ),
    );
  }
}
