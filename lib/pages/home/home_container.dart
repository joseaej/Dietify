// ignore_for_file: must_be_immutable

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dietify/pages/home/home_page.dart';
import 'package:dietify/pages/profile/profile_page.dart';
import 'package:dietify/pages/recipes/recipes_page.dart';
import 'package:dietify/pages/workout/workout_page.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(),
      RecipePage(),
      WorkoutPage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: blue,
        style: TabStyle.flip,
        items: [
          TabItem(icon: Icons.home, title: 'Inicio'),
          TabItem(icon: Icons.apple_outlined, title: 'Recetas'),
          TabItem(icon: Icons.person, title: 'Workout'),
          TabItem(icon: Icons.settings, title: 'Ajustes'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}
