import 'package:Dietify/pages/timer/timer_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerDown extends StatefulWidget {
  final int timeStart;
  const TimerDown({super.key, required this.timeStart});

  @override
  State<TimerDown> createState() => _TimerDownState();
}

class _TimerDownState extends State<TimerDown> {
  late final int timeStart;
  @override
  void initState() {
    timeStart = widget.timeStart;
    Provider.of<TimerViewmodel>(context, listen: false).start(Duration(minutes: timeStart));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewmodel = Provider.of<TimerViewmodel>(context);
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, size: 50, color: orange),
            SizedBox(width: 20),
            Text(
              '${viewmodel.timer}:${viewmodel.duration.inSeconds.remainder(60)}',
              style: TextStyle(fontSize: 50, color: background),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          elevation: 9,
          backgroundColor: orange,
          onPressed: () {
            viewmodel.pause();
          },
          child: Icon((viewmodel.isRunning)?Icons.stop:Icons.play_arrow, color: Colors.white),
        ),
      ),
    ));
  }
}
