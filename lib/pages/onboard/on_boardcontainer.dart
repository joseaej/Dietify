import 'package:Dietify/pages/onboard/on_board1.dart';
import 'package:Dietify/pages/onboard/on_board3.dart';
import 'package:Dietify/pages/onboard/on_board_viewmodel.dart';
import 'package:Dietify/pages/settings/settings_page.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardcontainer extends StatefulWidget {
  const OnBoardcontainer({super.key});

  @override
  State<OnBoardcontainer> createState() => _OnBoardcontainerState();
}

class _OnBoardcontainerState extends State<OnBoardcontainer> {
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              if(value==2){
                setState(() {
                  lastPage = true;
                });
              }
            },
            controller: OnBoardViewmodel.controller,
            children: [
              OnBoard1Page(),
              SettingsPage(),
              OnBoardPage3(user: null),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 20.w,
                  child:
                      TextButton(onPressed: () {
                        OnBoardViewmodel.controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                      }, child: const Text("Skip",style: TextStyle(color: orange),),),
                ),
                SmoothPageIndicator(
                  count: 3,
                  controller: OnBoardViewmodel.controller,
                  effect: SwapEffect(
                    activeDotColor: orange,
                    dotColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                  child: TextButton(
                    onPressed: () {},
                    child: Text((lastPage==true) ? "Done" : "Next", style: TextStyle(color: orange),),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
