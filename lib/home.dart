// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:dietify/profile_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar,
        bottomNavigationBar: _bottombar,
      ),
    );
  }

  AppBar get _appBar => AppBar(
        backgroundColor: Color.fromRGBO(226, 219, 122, 1),
        title: Text(
          "Dietify",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: onIconPressed, icon: Icon(Icons.message_sharp))
        ],
      );

  BottomAppBar get _bottombar => BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: onIconPressed,
                icon: Icon(
                  Icons.house_sharp,
                  size: 30,
                )),
            IconButton(
                onPressed: onIconPressed,
                icon: Icon(
                  Icons.search_sharp,
                  size: 30,
                )),
            IconButton(
                onPressed: onIconPressed,
                icon: Icon(
                  Icons.add_a_photo_rounded,
                  size: 30,
                )),
            IconButton(
                onPressed: onIconPressed,
                icon: Icon(
                  Icons.lightbulb,
                  size: 30,
                )),
            IconButton(
                onPressed: onProfilePressed,
                icon: Icon(
                  Icons.person,
                  size: 30,
                )),
          ],
        ),
      );
  void onIconPressed() {}

  void onProfilePressed() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ProfileScreen(),
    ));
  }
}
