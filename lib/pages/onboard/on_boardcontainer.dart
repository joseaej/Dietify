import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/onboard/on_board1.dart';
import 'package:Dietify/pages/onboard/on_board2.dart';
import 'package:Dietify/pages/onboard/on_board3.dart';
import 'package:Dietify/pages/onboard/on_board_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardcontainer extends StatefulWidget {
  UserApp? user;
  OnBoardcontainer({super.key, required this.user});

  @override
  State<OnBoardcontainer> createState() => _OnBoardcontainerState();
}

class _OnBoardcontainerState extends State<OnBoardcontainer> {
  late UserApp? user;
  bool lastPage = false;
  late OnBoardViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    user = widget.user;
    viewmodel = Provider.of<OnBoardViewmodel>(context, listen: false);
    viewmodel.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              if (value == 2) {
                setState(() {
                  lastPage = true;
                });
              }
            },
            controller: OnBoardViewmodel.controller,
            children: [
              OnBoard1Page(),
              OnBoard2Page(),
              OnBoardPage3(user: viewmodel.user),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20.w,
                child: TextButton(
                  onPressed: () {
                    OnBoardViewmodel.controller.animateToPage(2,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: orange),
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
                    OnBoardViewmodel.controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    (lastPage == true) ? "Next" : "Next",
                    style: TextStyle(color: orange),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
