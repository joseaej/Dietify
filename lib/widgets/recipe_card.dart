import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: skyBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.apple_outlined,
                color: font,
                size: 28,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.timer_sharp, color: grey600, size: 2.h),
                      SizedBox(width: 1.w),
                      Text(
                        "${recipe.cookingTime} min",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: grey600),
                      ),
                      SizedBox(width: 5.w),
                      Icon(Icons.local_fire_department,
                          color: Colors.red, size: 2.h),
                      SizedBox(width: 1.w),
                      Text(
                        "${recipe.calories?.toStringAsFixed(0) ?? '0'} kcal",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: grey600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildMacroChip(Icons.breakfast_dining, "Carbs",
                          recipe.carbs!, Colors.deepOrange.shade400),
                      SizedBox(width: 2.w),
                      _buildMacroChip(
                        Icons.fastfood,
                        "Grasa",
                        recipe.fat!,
                        Colors.amber.shade600,
                      ),
                      SizedBox(width: 2.w),
                      _buildMacroChip(Icons.fitness_center, "Prot",
                          recipe.protein!, Colors.green.shade600),
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

  Widget _buildMacroChip(
      IconData icon, String label, double value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: font),
          SizedBox(width: 4),
          Text(
            "${value.toStringAsFixed(1)}g",
            style: TextStyle(
                fontSize: 11, color: font, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
