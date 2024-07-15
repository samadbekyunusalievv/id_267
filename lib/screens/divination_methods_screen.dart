import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DivinationMethodsScreen extends StatefulWidget {
  @override
  _DivinationMethodsScreenState createState() =>
      _DivinationMethodsScreenState();
}

class _DivinationMethodsScreenState extends State<DivinationMethodsScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    ScrollableContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bazi (八字) analyzes the date and hour when a person was born. Normally, Bazi and Shouxiang can be used for telling one’s past and future, because a person\'s date of birth and palm will never change. It’s believed that changing your facial features also changes your destiny. How plastic surgery affects destiny is an ongoing debate, and naturally plastic surgeons are on the "no problem!" side.',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.start,
          ),
          Gap(20.h),
          Image.asset(
            'assets/image1.png',
          ),
        ],
      ),
    ),
    ScrollableContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qiu Qian (求签) is often seen at temples. The fortune teller will bring out a huge bundle of sticks (either 100, 60, or 32) called qian, which each have different Chinese characters inscribed on them. Then you shake a bamboo cylinder until one of the sticks drops out, and the fortune teller uses that stick to predict your future. It’s totally random, and supposedly only effective for a short period of time. People often choose this method when they want to make quick decision or get a good score on their upcoming exams.',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.start,
          ),
          Gap(20.h),
          Image.asset(
            'assets/image2.png',
          ),
        ],
      ),
    ),
    ScrollableContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zi Wei Dou Shu (紫薇斗数, Purple Star Astrology) is an important but less mainstream method. This one uses your birthday (based on the Chinese calendar) and twelve Chinese constellations to work out a life map (命盘) that shows your destiny and future relationships. It could predict, for example, a divorce at age 30–35. This method has much in common with Bazi, but it\'s way more complicated.',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.start,
          ),
          Gap(20.h),
          Image.asset(
            'assets/image3.png',
          ),
          Gap(20.h),
          Text(
            'This one is another method of feng shui (风水), the architecture / location choosing concept that\'s so popular that it\'s in the English Dictionary. Naturally, improving the feng shui in your house / office / whatever can improve your fortune.',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.start,
          ),
          Gap(20.h),
          Image.asset(
            'assets/image4.png',
          ),
        ],
      ),
    ),
  ];

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _onPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 24.h + _getBottomNavigationBarHeight(),
              right: 20.w,
              left: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: _onPreviousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(123.w, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(18.r),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/prev_icon.png',
                          width: 15.r,
                          height: 15.r,
                        ),
                        Gap(3.w),
                        Flexible(
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.r,
                              height: 1,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(width: 123.w),
                Text(
                  '${_currentPage + 1}',
                  style: TextStyle(
                    fontFamily: 'To Japan',
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                if (_currentPage < _pages.length - 1)
                  ElevatedButton(
                    onPressed: _onNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(123.w, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.r,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gap(8.w),
                        Image.asset(
                          'assets/icons/next_icon.png',
                          width: 15.r,
                          height: 15.r,
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(width: 123.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getBottomNavigationBarHeight() {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return bottomPadding;
  }
}

class ScrollableContent extends StatelessWidget {
  final Widget child;

  const ScrollableContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 118.h,
        bottom: 20.h,
        right: 20.w,
        left: 20.w,
      ),
      child: Container(
        width: 335.w,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(5.r),
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: child,
        ),
      ),
    );
  }
}
