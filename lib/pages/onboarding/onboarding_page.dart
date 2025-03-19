import 'package:dietify/pages/onboarding/onboarding_page2.dart';
import 'package:dietify/pages/onboarding/onboarding_page3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page1.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pagecontroller = PageController();
  bool isOnLastPage =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pagecontroller,
            onPageChanged: (value) {
              setState(() {
                if(value==2) {
                  isOnLastPage = true;
                } else {
                  isOnLastPage = false;
                }
              });
            },
            children: [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isOnLastPage?
                  GestureDetector(
                    onTap: () {
                      _pagecontroller.jumpToPage(0);
                    },
                    child: Text("Back"),
                  )
                  :GestureDetector(
                    onTap: () {
                      _pagecontroller.jumpToPage(2);
                    },
                    child: Text("Skip"),
                  ),
                  SmoothPageIndicator(controller: _pagecontroller, count: 3),
                  
                  isOnLastPage?
                  GestureDetector(
                    onTap: () {
                      _pagecontroller.nextPage(
                          duration: Duration(microseconds: 1000),
                          curve: Curves.linear);
                    },
                    child: Text("Done"),
                  ):
                  GestureDetector(
                    onTap: () {
                      _pagecontroller.nextPage(
                          duration: Duration(microseconds: 1000),
                          curve: Curves.linear);
                    },
                    child: Text("Next"),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
