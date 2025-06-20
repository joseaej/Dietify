import 'package:dietify/domain/providers/settings_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorkoutCardVertical extends StatelessWidget {
  final dynamic workout;
  final VoidCallback? onTap;

  const WorkoutCardVertical({
    super.key,
    required this.workout,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDark = settingsProvider.settings!.isDarkTheme;

    final Color textColor = isDark ? font : darkfont;
    final Color subTextColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
    final Color iconColor = isDark ? Colors.grey[300]! : Colors.grey[600]!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: (isDark)?background:lightBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.black45),
        ),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.name ?? 'Sin nombre',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 1.2.h),

            Row(
              children: [
                Icon(Icons.timer_outlined, size: 18.sp, color: iconColor),
                SizedBox(width: 2.w),
                Text(
                  '${workout.duration ?? "--"} min',
                  style: TextStyle(fontSize: 16.sp, color: subTextColor),
                ),
                const Spacer(),
                Icon(Icons.bolt_outlined, size: 18.sp, color: iconColor),
                SizedBox(width: 2.w),
                Text(
                  workout.intensity ?? '--',
                  style: TextStyle(fontSize: 16.sp, color: subTextColor),
                ),
              ],
            ),

            SizedBox(height: 1.2.h),

            if (workout.muscles != null)
              Row(
                children: [
                  Icon(Icons.fitness_center_outlined, size: 18.sp, color: iconColor),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      workout.muscles!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: subTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),

            const Spacer(),

            if (workout.calories != null)
              Row(
                children: [
                  Icon(Icons.local_fire_department_outlined,
                      size: 18.sp, color: Colors.orangeAccent),
                  SizedBox(width: 2.w),
                  Text(
                    '${workout.calories!.toStringAsFixed(0)} kcal',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: textColor,
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
