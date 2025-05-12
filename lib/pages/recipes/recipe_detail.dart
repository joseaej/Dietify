import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/recipe_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/recipe.dart';
import 'package:dietify/service/export_service.dart';
import 'package:dietify/service/file_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/providers/goal_provider.dart';
import '../../utils/theme.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Recipe recipe;
  late SettingsProvider settingsProvider;
  late RecipeProvider recipeProvider;
  late GoalProvider goalProvider;
  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    recipeProvider = Provider.of<RecipeProvider>(context);
    goalProvider = Provider.of<GoalProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    ExportService exportService = ExportService();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: blue,
            size: 3.5.h,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final file = await exportService.generateRecipePDF(recipe);
              FileService.openPDF(file);
            },
            icon: Icon(
              Icons.download,
              color: blue,
              size: 3.5.h,
            ),
          )
        ],
        title: Text(
          recipe.title,
          style: TextStyle(
            color: settingsProvider.settings!.isDarkTheme ? font : darkfont,
            fontSize: 20.sp,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCoockingTimeAndPersons(recipe.cookingTime ?? 10,
                  recipe.servings ?? 1, recipe.calories ?? 0),
              _buidMacrosCard(recipe),
              Text(
                "Ingredientes",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color:
                      settingsProvider.settings!.isDarkTheme ? font : darkfont,
                ),
              ),
              SizedBox(height: 2.h),
              _buildRecipeList(recipe.ingredients),
              SizedBox(height: 3.h),
              Text(
                "Pasos de elaboración",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color:
                      settingsProvider.settings!.isDarkTheme ? font : darkfont,
                ),
              ),
              SizedBox(height: 2.h),
              _buildRecipeList(recipe.steps),
              SizedBox(height: 3.h),
              _buildAddButton(() {
                goalProvider.updateCalories(recipe.calories!, "+");
                goalProvider.updateMacro(MacrosEnum.fat, recipe.fat ?? 0);
                goalProvider.updateMacro(
                    MacrosEnum.protein, recipe.protein ?? 0);
                goalProvider.updateMacro(MacrosEnum.carbs, recipe.carbs ?? 0);
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoockingTimeAndPersons(
      int coockingTime, int persons, double calories) {
    return Container(
      padding: EdgeInsets.all(5.w),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color:
            settingsProvider.settings!.isDarkTheme ? backgroundTextField : font,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          _buildHeaderItem(Icons.timer_outlined, coockingTime.toString()),
          _buildHeaderItem(Icons.local_fire_department, calories.toString()),
          _buildHeaderItem(Icons.person, persons.toString()),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 2.w,
        ),
        Text(text)
      ],
    );
  }

  Widget _buidMacrosCard(Recipe recipe) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 16),
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
              offset: Offset(0, 4),
            )
          ],
        ),
        child: _buildPieChart(recipe.carbs!, recipe.protein!, recipe.fat!));
  }

  Widget _buildRecipeList(List<String> steps) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: settingsProvider.settings!.isDarkTheme
                ? backgroundTextField
                : font,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: blue,
                ),
              ),
              Expanded(
                child: Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: settingsProvider.settings!.isDarkTheme
                        ? font
                        : darkfont,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton(Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 7.h,
        width: double.infinity,
        child: Center(
          child: Text(
            "AÑADIR",
            style: TextStyle(
              color: font,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(double fat, double carbs, double protein) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  border: Border.all(color: background, width: 2),
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Colors.amber.shade600,
                    value: fat,
                  ),
                  PieChartSectionData(
                    color: Colors.deepOrange.shade400,
                    value: carbs,
                  ),
                  PieChartSectionData(
                    color: Colors.green.shade600,
                    value: protein,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(Colors.amber.shade600, "Grasas"),
              _buildLegendItem(Colors.deepOrange.shade400, "Carbohidratos"),
              _buildLegendItem(Colors.green.shade600, "Proteínas"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: settingsProvider.settings!.isDarkTheme ? font : darkfont,
          ),
        ),
      ],
    );
  }
}
