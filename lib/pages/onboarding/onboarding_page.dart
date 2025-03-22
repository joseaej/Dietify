import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/repository/profile_repository.dart';
import 'package:dietify/pages/onboarding/on_board1.dart';
import 'package:dietify/pages/onboarding/on_board2.dart';
import 'package:dietify/pages/onboarding/on_board3.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../service/shared_preference_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pagecontroller = PageController();
  bool isOnLastPage = false;
  @override
  Widget build(BuildContext context) {
    ProfileProvider provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pagecontroller,
            onPageChanged: (value) {
              setState(() {
                if (value == 2) {
                  isOnLastPage = true;
                } else {
                  isOnLastPage = false;
                }
              });
            },
            children: [
              OnBoard1Page(),
              OnBoard2Page(),
              OnBoardPage3(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isOnLastPage
                      ? GestureDetector(
                          onTap: () {
                            _pagecontroller.jumpToPage(0);
                          },
                          child: Text("Back"),
                        )
                      : GestureDetector(
                          onTap: () {
                            _pagecontroller.jumpToPage(2);
                          },
                          child: Text("Skip"),
                        ),
                  SmoothPageIndicator(
                    controller: _pagecontroller,
                    count: 3,
                    effect: JumpingDotEffect(
                        dotColor: Colors.black26, activeDotColor: orange),
                  ),
                  isOnLastPage
                      ? GestureDetector(
                          onTap: () {
                            if (OnBoardPage3.formKey.currentState!.validate()) {
                              if (provider.profile != null) {
                                SharedPreferenceService.setProfileFromLocal(
                                    provider.profile!);
                                ProfileRepository()
                                    .updateProfile(provider.profile!);
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }
                            }
                          },
                          child: Text("Done"),
                        )
                      : GestureDetector(
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
