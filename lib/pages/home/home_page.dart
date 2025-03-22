import 'package:dietify/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profile;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Text(profile?.email ?? 'No email'),
          Text(profile?.username ?? 'No username'),
          Text(profile?.weight.toString() ?? 'No weight'),
          Text(profile?.height.toString() ?? 'No height'),
          Text(profile?.activityLevel ?? "Sedentario"),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/settings");
            },
          ),
        ],
      ),
    );
  }
}