import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WorkoutCard extends StatelessWidget {
  final String workoutName;
  final String duration;
  final String difficulty;
  final String calories;
  final String imageUrl;
  final Color fontColor;
  final Function()? onPressed;

  const WorkoutCard(
      {super.key,
      required this.workoutName,
      required this.duration,
      required this.difficulty,
      required this.calories,
      required this.imageUrl,
      required this.fontColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 25.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workoutName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconText(Icons.timer, duration),
                    Text(
                      difficulty,
                      style: TextStyle(
                        color: _getDifficultyColor(difficulty),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                _buildIconText(Icons.local_fire_department, "$calories kcal"),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onPressed,
              child: Text(
                "Start",
                style: TextStyle(
                  color: font,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700], size: 18),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp,),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'baja':
        return Colors.green;
      case 'media':
        return Colors.blue;
      case 'alta':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
