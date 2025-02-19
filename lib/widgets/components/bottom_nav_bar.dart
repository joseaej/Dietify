import 'package:Dietify/utils/theme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

ConvexAppBar get bottomNavbar {
  return ConvexAppBar(
    backgroundColor: orange,
    style: TabStyle.react,
    items: [
      TabItem(icon: Icons.home),
      TabItem(icon: Icons.apple),
      TabItem(icon: Icons.assessment),
    ],
    initialActiveIndex: 1,
    onTap: (int i) => print('click index=$i'),
  );
}
