import 'package:Dietify/pages/home/home_page.dart';
import 'package:Dietify/pages/onboard/on_board1.dart';
import 'package:Dietify/pages/onboard/on_board2.dart';
import 'package:Dietify/pages/onboard/on_board3.dart';
import 'package:Dietify/pages/onboard/on_board_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Dietify/models/user.dart';

class OnBoardcontainer extends StatefulWidget {
  final UserApp? user;
  const OnBoardcontainer({super.key, required this.user});

  @override
  State<OnBoardcontainer> createState() => _OnBoardcontainerState();
}

class _OnBoardcontainerState extends State<OnBoardcontainer> {
  late UserApp? user;
  bool lastPage = false;
  bool initPage = true;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return   
    SafeArea(
      child: Scaffold(
        body: Column(
        children: [
          Expanded(
            child: PageView(
              pageSnapping: true,
              onPageChanged: (value) {
                if (value == 2) {
                  setState(() {
                    lastPage = true;
                  });
                } else {
                  setState(() {
                    lastPage = false;
                  });
                }
                if (value != 0) {
                  setState(() {
                    initPage = false;
                  });
                } else {
                  setState(() {
                    initPage = true;
                  });
                }
              },
              controller: OnBoardViewmodel.controller,
              children: [
                Expanded(child: OnBoard1Page()),
                Expanded(child: OnBoard2Page()),
                Expanded(child: OnBoardPage3(user: user)),
              ],
            ),
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 20.w,
                  child: TextButton(
                    onPressed: () {
                      if (initPage == true) {
                        OnBoardViewmodel.controller.animateToPage(2,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      } else {
                        OnBoardViewmodel.controller.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Text(
                      (initPage == true) ? "Skip" : "Back",
                      style: const TextStyle(color: orange),
                    ),
                  ),
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
                    onPressed: () {
                      if (!lastPage) {
                        OnBoardViewmodel.controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.linear);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(user: user,),
                        ));
                      }
                    },
                    child: Text(
                      (lastPage == true) ? "Done" : "Next",
                      style: TextStyle(color: orange),
                    ),
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
