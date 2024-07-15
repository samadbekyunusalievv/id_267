import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'main_screen.dart';

class PremiumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/prev_icon.png',
            width: 25.r,
            height: 25.r,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Premium',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 44.h,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/premium_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Gap(143.h),
                  Image.asset(
                    'assets/logo.png',
                    width: 222.r,
                    height: 222.r,
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
                  Gap(100.h),
                  Text(
                    'NO ADS',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  Gap(20.h),
                  Text(
                    'FOR \$0.49',
                    style: TextStyle(
                      fontFamily: 'To Japan',
                      fontWeight: FontWeight.w400,
                      fontSize: 32.r,
                      height: 1.2,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(35.h),
                  GestureDetector(
                    onTap: () {
                      _showDetailsDialog(context);
                    },
                    child: Container(
                      width: 335.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'See Details',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle Terms of Use
                        },
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
                      Gap(30.w),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                          );
                        },
                        child: Text(
                          'Restore',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.r,
                            letterSpacing: -0.4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gap(30.w),
                      TextButton(
                        onPressed: () {
                          // Handle Privacy Policy
                        },
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
          ),
        ],
      ),
    );
  }

  Future<void> _showDetailsDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(5.r),
                bottomLeft: Radius.circular(5.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.7),
            child: Container(
              width: 335.w,
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/premium_dialog_bg.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(5.r),
                  bottomLeft: Radius.circular(5.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Gap(16.h),
                  Text(
                    'NO ADS',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.r,
                      height: 23.h / 20.r,
                      color: Colors.white,
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    'FOR \$0.49',
                    style: TextStyle(
                      fontFamily: 'To Japan',
                      fontWeight: FontWeight.w400,
                      fontSize: 28.r,
                      color: Colors.white,
                      height: 50.h / 29.r,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: Container(
                        width: 315.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'See Details',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.r,
                              height: 1.h,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    child: Text(
                      'Restore',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.r,
                        height: 19.h / 16.r,
                        color: Colors.white,
                      ),
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
