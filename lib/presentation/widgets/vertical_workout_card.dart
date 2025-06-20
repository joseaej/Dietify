import 'package:dietify/domain/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:dietify/domain/models/workout.dart';
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
        height: 28.h,
        margin: EdgeInsets.symmetric(horizontal: 1.5.w),
        padding: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
          color: settingsProvider.settings!.isDarkTheme
              ? backgroundTextField
              : font,
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(color: borderColor, width: 0.3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.5.w,
              offset: Offset(0, 1.2.w),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
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
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 0.8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_sharp, color: grey600, size: 3.w),
                SizedBox(width: 1.w),
                Text(
                  "${workout.duration} min",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: grey600,
                        fontSize: 15.sp,
                      ),
                ),
              ],
            ),
            SizedBox(height: 0.6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: Colors.red, size: 3.w),
                SizedBox(width: 1.w),
                Text(
                  "${workout.calories} kcal",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: grey600,
                        fontSize: 15.sp,
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
