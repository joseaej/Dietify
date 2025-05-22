import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [blue, skyBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              workout.name ?? 'Sin nombre',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                Icon(Icons.timer, color: Colors.white70, size: 16),
                const SizedBox(width: 4),
                Text('${workout.duration ?? "--"} min',
                    style: TextStyle(color: Colors.white70, fontSize: 18.sp)),
                const Spacer(),
                Icon(Icons.bolt, color: Colors.white70, size: 18.sp),
                const SizedBox(width: 4),
                Text(workout.intensity ?? '--',
                    style: TextStyle(color: Colors.white70, fontSize: 18.sp)),
              ],
            ),

            const SizedBox(height: 6),

            if (workout.muscles != null)
              Row(
                children: [
                  Icon(Icons.accessibility_new, color: Colors.white70, size: 18.sp),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      workout.muscles!,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            const Spacer(),

            if (workout.calories != null)
              Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 18.sp),
                  const SizedBox(width: 4),
                  Text(
                    '${workout.calories!.toStringAsFixed(0)} kcal',
                    style:  TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
