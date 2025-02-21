import 'package:Dietify/utils/theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class OnBoard2Page extends StatefulWidget {
  const OnBoard2Page({super.key});

  @override
  State<OnBoard2Page> createState() => _OnBoard2PageState();
}

class _OnBoard2PageState extends State<OnBoard2Page> {
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
                padding: const EdgeInsets.fromLTRB(13, 20, 0, 0),
                child: FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: Wrap(
                    children: [
                      Text(
                        "Connect with your ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "best version ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                        "of yourself",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),Text(
                        " push ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                       "push your limits " ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       "reach " ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      Text(
                       "your goals and" ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       " live the sport like never before. " ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                       "Every step takes you closer to greatness " ,
                       style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
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

  static const String assetName = 'assets/images/personal_trainer.svg';
  final Widget cookingIcon = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Trainer',
  );
}
