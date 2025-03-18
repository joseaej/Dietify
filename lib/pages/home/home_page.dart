import 'package:dietify/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Profile profile;
  @override
  Widget build(BuildContext context) {
    profile = Provider.of<Profile>(context);
    return Column(
      children: [
        Text(profile.email!),
        Text(profile.username!),
      ],
    );
  }
}