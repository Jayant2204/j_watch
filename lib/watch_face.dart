import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class WatchFaceView extends StatefulWidget {
  const WatchFaceView({Key? key}) : super(key: key);

  static final colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.teal,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];

  @override
  State<WatchFaceView> createState() => _WatchFaceViewState();
}

class _WatchFaceViewState extends State<WatchFaceView> {
  int firstColorIndex = 0;
  int secondColorIndex = 1;
  double diameter = 250;

  double angle = DateTime.now().second * 6;
  double milliseconds = DateTime.now().second.toDouble() * 1000 +
      DateTime.now().millisecond.toDouble();

  // function that changes color index randomly
  void changeColorIndex() {
    setState(() {
      firstColorIndex = random.nextInt(WatchFaceView.colorList.length);
      secondColorIndex = random.nextInt(WatchFaceView.colorList.length);
    });
  }

  math.Random random = math.Random();

  Timer? timerSecs;

  void runSecondsTimer() {
    timerSecs = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        milliseconds = DateTime.now().second.toDouble() * 1000 +
            DateTime.now().millisecond.toDouble();
        angle = ((((milliseconds / 1000) * 6)) - 90) / 360;
        if (milliseconds < 100) {
          changeColorIndex();
        }
      });
    });
  }

  @override
  void initState() {
    runSecondsTimer();
    // runMinsTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Stack(
              children: [
                Center(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(angle),
                    child: Container(
                      height: diameter,
                      width: diameter,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            WatchFaceView.colorList[firstColorIndex],
                            WatchFaceView.colorList[secondColorIndex],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: diameter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (DateTime.now().hour % 12).toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: diameter * 0.2,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(5, 5),
                              )
                            ],
                          ),
                        ),
                        Text(
                          DateTime.now().minute.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: diameter * 0.2,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(5, 5),
                              )
                            ],
                          ),
                        ),
                        // Text notifying am/pm
                        Text(DateTime.now().hour < 12 ? 'AM' : 'PM'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
