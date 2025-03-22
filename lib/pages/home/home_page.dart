import 'package:dietify/models/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Profile? profile;
  
  const HomePage({super.key, required this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Text(widget.profile!.email ?? 'No email'),
          Text(widget.profile!.username ?? 'No username'),
          Text(widget.profile!.weight.toString()),
          Text(widget.profile!.height.toString()),
          Text(widget.profile!.activityLevel??"Sedentario"),
        ],
      ),
    );
  }
}
