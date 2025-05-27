import 'package:dietify/models/providers/achievements_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AchivementPage extends StatelessWidget {
  AchivementPage({super.key});
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    bool isDarkTheme = settingsProvider.settings!.isDarkTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logros'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Consumer<AchievementsProvider>(
        builder: (context, achievementsProvider, child) {
          final achievements = achievementsProvider.achievements;

          if (achievements.isEmpty) {
            return const Center(
              child: Text(
                'No hay logros todavía.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                double achievementProgressPercent =
                    (achievement.currentPercent! / achievement.maxPercent!) *
                        100;
                if (achievement.maxPercent == 0) {
                  achievementProgressPercent = 0;
                }

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    tileColor: isDarkTheme ? background : lightBackground,
                    textColor: isDarkTheme ? font : darkfont,
                    leading: Icon(Icons.emoji_events,
                        color: (achievement.isAchievementCompleted)
                            ? Colors.amber
                            : (isDarkTheme)?lightGray:Colors.black45),
                    title: Text(
                      achievement.title,
                      style: TextStyle(color: isDarkTheme ? font : background),
                    ),
                    subtitle: Text(
                      achievement.description,
                      style: TextStyle(color: isDarkTheme ? font : background),
                    ),
                    trailing: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: achievement.currentPercent! /
                                achievement.maxPercent!,
                            strokeWidth: 6,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation(blue),
                          ),
                        ),
                        Text(
                          '${achievementProgressPercent.ceil()}%',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: (isDarkTheme) ? font : darkfont,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
