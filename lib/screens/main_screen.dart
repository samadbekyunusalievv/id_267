import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:id_267/screens/divination_methods_screen.dart';
import 'package:id_267/screens/fortune_telling_screen.dart';
import 'package:id_267/screens/good_bad_days_screen.dart';
import 'package:id_267/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isDialogOpen = false;

  static final List<Widget> _pages = <Widget>[
    FortuneTellingScreen(onDialogOpen: (bool isOpen) {}),
    DivinationMethodsScreen(),
    GoodBadDaysScreen(onDialogOpen: (bool isOpen) {}),
    SettingsScreen(),
  ];

  static const List<String> _titles = <String>[
    'Fortune Telling',
    'Divination Methods',
    'Good & Bad days',
    'Settings',
  ];

  static final List<Map<String, String>> _icons = [
    {
      'selected': 'assets/icons/selected_1.png',
      'unselected': 'assets/icons/unselected_1.png',
    },
    {
      'selected': 'assets/icons/selected_2.png',
      'unselected': 'assets/icons/unselected_2.png',
    },
    {
      'selected': 'assets/icons/selected_3.png',
      'unselected': 'assets/icons/unselected_3.png',
    },
    {
      'selected': 'assets/icons/selected_4.png',
      'unselected': 'assets/icons/unselected_4.png',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setDialogOpen(bool isOpen) {
    setState(() {
      _isDialogOpen = isOpen;
    });
  }

  Widget _buildIcon(int index) {
    return Image.asset(
      _selectedIndex == index
          ? _icons[index]['selected']!
          : _icons[index]['unselected']!,
      width: 70.w,
      height: 40.h,
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages[0] = FortuneTellingScreen(onDialogOpen: _setDialogOpen);
    _pages[2] = GoodBadDaysScreen(onDialogOpen: _setDialogOpen);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        title: Text(
          _titles[_selectedIndex],
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
                image: AssetImage('assets/main_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _pages[_selectedIndex],
          if (_isDialogOpen)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(0),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(1),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(2),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(3),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.transparent,
              unselectedItemColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              iconSize: 0,
            ),
          ),
        ),
      ),
    );
  }
}
