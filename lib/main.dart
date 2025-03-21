import 'package:dietify/pages/auth/sign_up_page.dart';
import 'package:dietify/pages/home/home_page.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/profile.dart';
import 'models/providers/profile_provider.dart';
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

  final Profile? savedProfile =
      await SharedPreferenceService.getProfileFromLocal();
  final String route = savedProfile != null ? "/home" : "/login";

  runApp(MainApp(route: route, savedProfile: savedProfile));
}

class MainApp extends StatelessWidget {
  final String route;
  final Profile? savedProfile;

  const MainApp({super.key, required this.route, this.savedProfile});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(
            create: (context) => AuthService(
              profile: savedProfile ?? Profile(email: "", username: ""),
              supabase: Supabase.instance,
            ),
          ),
        ],
        child: Sizer(builder: (context, orientation, devicetype) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dietify',
            theme: lightTheme,
            darkTheme: darkTheme,
            initialRoute: "/onboarding",
            routes: {
              '/home': (context) => HomePage(
                  profile:
                      savedProfile ?? Profile(email: "", username: "")),
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignupPage(),
              '/onboarding': (context) => OnboardingPage(),
            },
            home: savedProfile != null
                ? HomePage(profile: savedProfile)
                : LoginScreen(),
          );
        }));
  }
}
