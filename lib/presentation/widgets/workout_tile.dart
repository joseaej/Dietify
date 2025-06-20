
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';

class WorkoutTile extends StatelessWidget {
  final String date;
  final String label;
  final int duration;

  const WorkoutTile({
    super.key,
    required this.date,
    required this.label,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date,),
          Text(label,),
          Text("$duration min",),
        ],
      ),
    );
  }
}
