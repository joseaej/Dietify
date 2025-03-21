import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/theme.dart';

class OnBoard1Page extends StatefulWidget {
  const OnBoard1Page({super.key});

  @override
  State<OnBoard1Page> createState() => _OnBoard1PageState();
}

class _OnBoard1PageState extends State<OnBoard1Page> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isPortrait ? 5.w : 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isPortrait ? 8.h : 3.h),
              Center(
                child: SizedBox(
                  height: isPortrait ? 35.h : 25.h,
                  child: FadeIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 3000),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: cookingIcon,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isPortrait ? 4.h : 2.h),
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: FadeIn(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    "Welcome to Dietify",
                    style: TextStyle(
                      fontSize: isPortrait ? 25.sp : 20.sp,
                      fontWeight: FontWeight.bold,
                      color: backgroundTextField,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isPortrait ? 2.h : 1.h),
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: FadeIn(
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 1000),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Achieve your health goals with "),
                        TextSpan(
                          text: "Dietify",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const TextSpan(
                            text: ", your ultimate diet planner! Discover "),
                        TextSpan(
                          text: "personalized ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const TextSpan(
                            text: "meal plans, delicious recipes, and a "),
                        TextSpan(
                          text: "supportive community",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const TextSpan(
                            text:
                                " to keep you inspired every step of the way. "),
                        TextSpan(
                          text: "Let's get started!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: isPortrait ? 15.sp : 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: isPortrait ? 10 : 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const String assetName = 'assets/images/cooking.svg';
  final Widget cookingIcon = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Food',
  );
}
