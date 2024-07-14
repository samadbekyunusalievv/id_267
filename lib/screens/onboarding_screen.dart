import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Gap(225.h),
                Image.asset(
                  'assets/logo.png',
                  width: 161.r,
                  height: 161.r,
                ),
                Gap(30.h),
                Text(
                  'Face to Fate',
                  style: TextStyle(
                    fontFamily: 'To Japan',
                    fontWeight: FontWeight.w400,
                    fontSize: 32.r,
                    height: 1.2,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(196.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(335.w, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(5.r),
                        bottomLeft: Radius.circular(5.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _showNotificationDialog(context);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                Gap(25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terms of Use',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.r,
                          letterSpacing: -0.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Gap(60.w),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.r,
                          letterSpacing: -0.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotificationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
            child: Container(
              padding: EdgeInsets.zero,
              width: 270.w,
              height: 170.h,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Gap(16.h),
                      Text(
                        "“Face to Fate” Would Like to\n Send You Notifications",
                        style: TextStyle(
                          fontSize: 17.r,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.41,
                          height: 22.h / 17.r,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(10.h),
                      Text(
                        "Notifications can include alerts,\n sounds, and icons. You can customize\n them in Settings.",
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13.r,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.08,
                          color: Colors.white,
                          height: 16.h / 13.r,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(10.r),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(20.w),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );
                              },
                              child: Text(
                                "Don't allow",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.r,
                                  height: 22.h / 17.r,
                                ),
                              ),
                            ),
                            Gap(54.w),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.r,
                                  height: 22.h / 17.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 132.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1.h,
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                  ),
                  Positioned(
                    top: 132.h,
                    left: 135.w,
                    bottom: 0,
                    child: Container(
                      width: 1.w,
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
