import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'premium_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 118.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: _toggleNotifications,
              child: Container(
                width: 335.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14.h,
                      left: 31.w,
                      child: Text(
                        'On',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          color: _notificationsEnabled
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          height: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14.h,
                      right: 29.w,
                      child: Text(
                        'Off',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          color: _notificationsEnabled
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20.h),
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
            Gap(20.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PremiumScreen()),
                );
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
            Gap(20.h),
            GestureDetector(
              onTap: () {
                // Handle Privacy Policy action
              },
              child: Container(
                width: 335.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Gap(20.h),
            GestureDetector(
              onTap: () {
                // Handle Terms of Service action
              },
              child: Container(
                width: 335.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
