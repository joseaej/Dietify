import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:dietify/models/workout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VerticalWorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const VerticalWorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w, 
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: settingsProvider.settings!.isDarkTheme
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(163, 137, 208, 243),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.fitness_center_rounded,
                color: blue,
                size: 6.h,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              workout.name!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0.8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_sharp, color: grey600, size: 14),
                const SizedBox(width: 4),
                Text(
                  "${workout.duration} min",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: grey600,
                        fontSize: 16.sp,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: Colors.red, size: 14),
                const SizedBox(width: 4),
                Text(
                  "${workout.calories} kcal",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: grey600,
                        fontSize: 16.sp,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
