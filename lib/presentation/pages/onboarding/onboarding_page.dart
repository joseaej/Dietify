import 'package:dietify/domain/providers/profile_provider.dart';
import 'package:dietify/domain/repository/profile_repository.dart';
import 'package:dietify/presentation/pages/onboarding/on_board1.dart';
import 'package:dietify/presentation/pages/onboarding/on_board2.dart';
import 'package:dietify/presentation/pages/onboarding/on_board3.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/service/shared_preference_service.dart';


// ignore: must_be_immutable
class OnboardingPage extends StatefulWidget {
  bool showBottomBar = true;
  OnboardingPage({super.key});

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
                isOnLastPage = value == 2;
              });
            },
            children: [
              OnBoard1Page(),
              OnBoard2Page(),
              OnBoardPage3(),
            ],
          ),
          (widget.showBottomBar)
              ? Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
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
                          dotColor: Colors.black26,
                          activeDotColor: blue,
                        ),
                      ),
                      isOnLastPage
                          ? GestureDetector(
                              onTap: () {
                                if (OnBoardPage3.formKey.currentState!
                                    .validate()) {
                                  if (provider.profile != null) {
                                    debugPrint(provider.profile!.toString());
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
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text("Next"),
                            ),
                    ],
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
