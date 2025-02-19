// ignore_for_file: must_be_immutable

import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/macros/macros_page.dart';
import 'package:Dietify/pages/settings/settings_page.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserApp? user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(user: widget.user),
      MacrosPage(user: widget.user,),
      SettingsPage(user: widget.user,),
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
        backgroundColor: orange,
        style: TabStyle.flip,
        items: [
          TabItem(icon: Icons.home, title: 'Inicio'),
          TabItem(icon: Icons.apple, title: 'Nutrición'),
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

class HomeScreen extends StatelessWidget {
  UserApp? user;

  HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Bienvenido${(user?.username != null) ? " ${user!.username}" : ", de vuelta"}')),
      body: Center(child: Text('Página de Inicio')),
    );
  }
}
