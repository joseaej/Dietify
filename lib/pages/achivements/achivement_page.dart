import 'package:dietify/models/providers/achievements_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchivementPage extends StatefulWidget {
  const AchivementPage({super.key});

  @override
  State<AchivementPage> createState() => _AchivementPageState();
}

class _AchivementPageState extends State<AchivementPage> {
  late AchievementsProvider achivementsProvider; 
  @override
  Widget build(BuildContext context) {
    achivementsProvider = Provider.of<AchievementsProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            itemCount: achivementsProvider.achievements.length,
            itemBuilder: (context, index) {
              
          },)
        ],
      ),
    );
  }
}