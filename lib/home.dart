// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // Renombramos el GlobalKey para que sea más claro
  final GlobalKey<ScaffoldState> _scaffoldcontext = GlobalKey<ScaffoldState>();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldcontext,
        appBar: MyAppBar(scaffoldKey: _scaffoldcontext), 
        endDrawer: _drawersettings, 
        body: Center(
          child: Text('Contenido de la app'), 
        ),
      ),
    );
  }
}

Drawer get _drawersettings => Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Ajustes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Información'),
            onTap: () {},
          ),
        ],
      ),
    );

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyAppBar({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.lightGreen,
      title: Text(
        "Dietify",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings), 
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
