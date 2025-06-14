import 'package:dietify/models/achievements.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AchivementsItem extends StatefulWidget {
  final Achievements achievement;
  final Function()? onTap;

  const AchivementsItem({
    super.key,
    required this.achievement,
    required this.onTap,
  });

  @override
  State<AchivementsItem> createState() => _AchivementsItemState();
}

class _AchivementsItemState extends State<AchivementsItem> {
  late Achievements achievement;
  late SettingsProvider settingsProvider;

  @override
  void initState() {
    super.initState();
    achievement = widget.achievement;
  }

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    bool isDarkTheme = settingsProvider.settings!.isDarkTheme;

    double progressPercent = (achievement.currentPercent == 0 || achievement.maxPercent == 0)
        ? 0
        : (achievement.currentPercent! / achievement.maxPercent!);
    int percentText = (progressPercent * 100).ceil();

    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkTheme ? backgroundTextField : font,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blue,
                  ),
                  child: const Icon(
                    Icons.star_border_outlined,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        achievement.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: isDarkTheme ? font : darkfont,
                        ),
                      ),
                      Text(
                        achievement.description,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: isDarkTheme ? lightGray : darkfont,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: progressPercent,
                            strokeWidth: 6,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation(blue),
                          ),
                        ),
                        Text(
                          '$percentText%',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkTheme ? font : darkfont,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Completado',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDarkTheme ? font : darkfont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
