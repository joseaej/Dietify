import 'package:Dietify/models/workout';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget workoutCardAdd(Workout workout, Function()? onPressed) {
  return GestureDetector(
    child: Container(
      width: 100.w,
      height: 14.h, // Ajuste de altura para un diseño más compacto
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícono dinámico según el tipo de entrenamiento
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getWorkoutColor(workout.type),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getWorkoutIcon(workout.type),
              color: Colors.white,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  workout.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.timer, size: 14.sp, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(
                      '${workout.duration} min',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.local_fire_department,
                        size: 14.sp, color: Colors.redAccent),
                    SizedBox(width: 4),
                    Text(
                      '${workout.calories} kcal',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  '${workout.type} • ${workout.intensity}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Icono de "más" al final
          IconButton(
            icon:
                Icon(Icons.add_circle_outline, color: Colors.grey, size: 24.sp),
            onPressed: onPressed,
          ),
        ],
      ),
    ),
  );
}

// Función para asignar íconos según el tipo de workout
IconData _getWorkoutIcon(String type) {
  switch (type.toLowerCase()) {
    case 'cardio':
      return Icons.directions_run;
    case 'fuerza':
      return Icons.fitness_center;
    case 'hiit':
      return Icons.flash_on;
    case 'movilidad':
      return Icons.self_improvement;
    case 'otro':
      return Icons.sports;
    default:
      return Icons.sports_gymnastics;
  }
}

// Función para asignar colores según el tipo de workout
Color _getWorkoutColor(String type) {
  switch (type.toLowerCase()) {
    case 'cardio':
      return Colors.blueAccent;
    case 'fuerza':
      return Colors.orangeAccent;
    case 'hiit':
      return Colors.redAccent;
    case 'movilidad':
      return Colors.greenAccent;
    case 'otro':
      return Colors.purpleAccent;
    default:
      return Colors.grey;
  }
}
