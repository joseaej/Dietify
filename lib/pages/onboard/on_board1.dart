import 'package:Dietify/utils/theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class OnBoard1Page extends StatefulWidget {
  const OnBoard1Page({super.key});

  @override
  State<OnBoard1Page> createState() => _OnBoard1PageState();
}

class _OnBoard1PageState extends State<OnBoard1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: SizedBox(
                  height: 40.h,
                  child: FadeIn(
                    delay: Duration(milliseconds: 400),
                    duration: Duration(milliseconds: 3000),
                    child: cookingIcon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: FadeIn(
                  delay: Duration(milliseconds: 600),
                  duration: Duration(milliseconds: 3000),
                  child: Text(
                    "Welcome to Dietify",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: backgroundTextField
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                child: FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: Wrap(
                    children: [
                      Text(
                        "Achieve your health goals with",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        " Dietify",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                        "your ultimate diet planner and tracker! Discover",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),Text(
                        "personalized ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                       "meal plans, delicious recipes, and a" ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       "supportive community" ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                       " to keep you inspired" ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       "every step of the way. " ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       "Let's get started!" ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                    ],
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
