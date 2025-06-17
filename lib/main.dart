import 'package:dietify/models/providers/achievements_provider.dart';
import 'package:dietify/models/providers/goal_provider.dart';
import 'package:dietify/models/providers/recipe_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/providers/workout_provider.dart';
import 'package:dietify/pages/achivements/achivement_page.dart';
import 'package:dietify/pages/auth/sign_up_page.dart';
import 'package:dietify/pages/home/home_container.dart';
import 'package:dietify/pages/permisions/permisions_handler_page.dart';
import 'package:dietify/pages/profile/profile_page.dart';
import 'package:dietify/pages/recipes/recipes_page.dart';
import 'package:dietify/pages/settings/settings_page.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/image_service.dart';
import 'package:dietify/service/notification_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/service/storage_service.dart';
import 'package:dietify/widgets/splash_page.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_LINK'] ?? '',
    anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
  );

  String route = await SharedPreferenceService.getProfileFromLocal() != null
      ? "/spash"
      : "/login";

  final Settings? settings = await SharedPreferenceService.getSettings();
  DateTime? lastGoalsSaved = await SharedPreferenceService.getLastGoalDate();

  if (lastGoalsSaved != null &&
      DateTime.now().difference(lastGoalsSaved).inDays >= 1) {
    SharedPreferenceService.clearGoals();
  }

  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  runApp(MainApp(
    route: route,
    initialSettings: settings,
  ));
}

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  String route;
  final Settings? initialSettings;

  MainApp({super.key, required this.route, this.initialSettings});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => AchievementsProvider()),
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => ImageService()),
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
          GoalProvider goalsProvider = context.read<GoalProvider>();
          WorkoutProvider workoutProvider = context.read<WorkoutProvider>();
          AchievementsProvider achievementsProvider =
              context.read<AchievementsProvider>();

          SystemChannels.lifecycle.setMessageHandler((msg) async {
            if (msg == AppLifecycleState.paused.toString()) {
              workoutProvider.getRandomWorkout();
              goalsProvider.savaGoalToLocal();
              workoutProvider.saveLastWorkout();
              achievementsProvider.saveAchievements();
              await SharedPreferenceService.saveLastGoalDate(DateTime.now());
            }
            return null;
          });
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                navigatorKey: navigatorKey,
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
                  '/profile': (context) => ProfilePage(),
                  '/login': (context) => LoginScreen(),
                  '/signup': (context) => SignupPage(),
                  '/recipes': (context) => RecipePage(),
                  '/onboarding': (context) => OnboardingPage(),
                  '/settings': (context) => SettingsPage(),
                  "/spash": (context) => SplashScreen(
                        route: "/home",
                        seconds: 4,
                      ),
                  '/permissions': (context) => PermisionsHandlerPage(),
                  '/achivements': (context) => AchivementPage()
                },
              );
            },
          );
        },
      ),
    );
  }
}
