import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static/fortune_data.dart';

class FortuneTellingScreen extends StatefulWidget {
  final void Function(bool) onDialogOpen;

  const FortuneTellingScreen({required this.onDialogOpen});

  @override
  _FortuneTellingScreenState createState() => _FortuneTellingScreenState();
}

class _FortuneTellingScreenState extends State<FortuneTellingScreen> {
  final double _shakeThreshold = 2.7;
  double _lastShakeTimestamp = 0;
  final double _shakeTimeout = 1000;
  Timer? _timer;
  bool _isDialogOpen = false;

  String? _dailyFortune;
  DateTime? _lastCheckedDate;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen(_onAccelerometerEvent);
    _checkDailyFortune();
    _startDailyCheckTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDailyCheckTimer() {
    _lastCheckedDate = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      if (_lastCheckedDate?.day != now.day) {
        _lastCheckedDate = now;
        _checkDailyFortune();
      }
    });
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    double gX = event.x / 9.8;
    double gY = event.y / 9.8;
    double gZ = event.z / 9.8;
    double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

    if (gForce > _shakeThreshold) {
      double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
      if (currentTime - _lastShakeTimestamp > _shakeTimeout && !_isDialogOpen) {
        _lastShakeTimestamp = currentTime;
        _showFortuneDialog();
      }
    }
  }

  Future<void> _checkDailyFortune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedFortune = prefs.getString('dailyFortune');
    String? lastFortuneDateString = prefs.getString('lastFortuneDate');
    DateTime today = DateTime.now();

    if (lastFortuneDateString != null) {
      DateTime lastFortuneDate = DateTime.parse(lastFortuneDateString);
      if (lastFortuneDate.day == today.day) {
        setState(() {
          _dailyFortune = storedFortune;
        });
        return;
      }
    }

    String newFortune = getRandomFortune();
    await prefs.setString('dailyFortune', newFortune);
    await prefs.setString('lastFortuneDate', today.toIso8601String());

    setState(() {
      _dailyFortune = newFortune;
    });
  }

  void _showFortuneDialog() {
    _isDialogOpen = true;
    widget.onDialogOpen(true);
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  width: 350.w,
                  height: 490.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 60.h,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/open_paper.png',
                          width: 350.w,
                          height: 444.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/close_icon.png',
                            width: 34.r,
                            height: 34.r,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onDialogOpen(false);
                            setState(() {
                              _isDialogOpen = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(flex: 2),
                              Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      _dailyFortune ?? '',
                                      style: TextStyle(
                                        fontFamily: 'To Japan',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24.r,
                                        color: Colors.black,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    _dailyFortune ?? '',
                                    style: TextStyle(
                                      fontFamily: 'To Japan',
                                      fontSize: 24.r,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      widget.onDialogOpen(false);
      setState(() {
        _isDialogOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 118.h),
        child: Column(
          children: [
            Text(
              'Shake the \n phone',
              style: TextStyle(
                fontFamily: 'To Japan',
                fontWeight: FontWeight.w400,
                fontSize: 32.r,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(5.h),
            Image.asset(
              'assets/ewer.png',
              width: 327.84.w,
              height: 462.h,
            ),
          ],
        ),
      ),
    );
  }
}
