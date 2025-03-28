import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecipeCard extends StatelessWidget {
  final String? recipeName;
  final String? recipeUrl;

  const RecipeCard({super.key, this.recipeName, this.recipeUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              recipeUrl ??
                  "https://img.spoonacular.com/recipes/659316-556x370.jpg",
              height: 25.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              recipeName ?? "Burger",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,0,0,0),
            child: _buildIconText(Icons.lock_clock,"42min"),
          )
        ],
      ),
    );
  }
    Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp,),
        ),
      ],
    );
  }
}
