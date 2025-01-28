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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
                    child: training,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Take one step closer to your goals with ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Dietify",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                        TextSpan(
                          text: ", your perfect companion for a healthy lifestyle. ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Turn your energy",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                        TextSpan(
                          text: " into strength with plans tailored just for you. ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Push your limits",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                        TextSpan(
                          text: " and build the body you've always dreamed of. ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Let's crush it together!",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
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
  final Widget training = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Trainer',
  );
}
