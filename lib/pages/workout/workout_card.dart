import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:dietify/models/workout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorkoutCard extends StatelessWidget {
  final Recipe workout;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (settingsProvider.settings!.isDarkTheme)
              ? backgroundTextField
              : font,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(163, 137, 208, 243),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.fitness_center_rounded,
                color: blue,
                size: 28,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name!,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_sharp,
                        color: grey600,
                        size: 2.h,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "${workout.duration.toString()} min",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: grey600,
                            ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 2.h,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "${workout.calories!} kcal",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: grey600,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 18, color: grey600),
          ],
        ),
      ),
    );
  }
}
