import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/dietify_icon.webp",
            width: 90.w,
            height: 90.h,
          ),
          LoadingAnimationWidget.staggeredDotsWave(
            size: 50,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
