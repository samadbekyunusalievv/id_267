import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoodBadDaysScreen extends StatefulWidget {
  final void Function(bool) onDialogOpen;

  const GoodBadDaysScreen({required this.onDialogOpen});

  @override
  _GoodBadDaysScreenState createState() => _GoodBadDaysScreenState();
}

class _GoodBadDaysScreenState extends State<GoodBadDaysScreen> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, Color> _markedDates = {};
  int _badDaysCount = 0;
  int _goodDaysCount = 0;
  int _neutralDaysCount = 0;

  @override
  void initState() {
    super.initState();
    _loadMarkedDates();
  }

  Future<void> _loadMarkedDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _badDaysCount = prefs.getInt('badDaysCount') ?? 0;
      _goodDaysCount = prefs.getInt('goodDaysCount') ?? 0;
      _neutralDaysCount = prefs.getInt('neutralDaysCount') ?? 0;
      _markedDates = (prefs.getStringList('markedDates') ?? []).asMap().map(
            (index, dateStr) => MapEntry(
              DateTime.parse(dateStr),
              Color(prefs.getInt('color_$dateStr') ?? Colors.transparent.value),
            ),
          );
    });
  }

  Future<void> _saveMarkedDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('badDaysCount', _badDaysCount);
    prefs.setInt('goodDaysCount', _goodDaysCount);
    prefs.setInt('neutralDaysCount', _neutralDaysCount);
    List<String> markedDates =
        _markedDates.keys.map((date) => date.toIso8601String()).toList();
    prefs.setStringList('markedDates', markedDates);
    _markedDates.forEach((date, color) {
      prefs.setInt('color_${date.toIso8601String()}', color.value);
    });
  }

  void _onDaySelected(DateTime day) {
    widget.onDialogOpen(true);
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: ColorSelectionDialog(
                selectedDate: day,
                onColorSelected: (color) {
                  setState(() {
                    if (_markedDates[day] != color) {
                      if (_markedDates[day] ==
                          const Color.fromRGBO(198, 0, 0, 1)) {
                        _badDaysCount--;
                      }
                      if (_markedDates[day] ==
                          const Color.fromRGBO(0, 179, 61, 1)) {
                        _goodDaysCount--;
                      }
                      if (_markedDates[day] ==
                          const Color.fromRGBO(191, 191, 191, 1)) {
                        _neutralDaysCount--;
                      }
                      _markedDates[day] = color;
                      if (color == const Color.fromRGBO(198, 0, 0, 1)) {
                        _badDaysCount++;
                      }
                      if (color == const Color.fromRGBO(0, 179, 61, 1)) {
                        _goodDaysCount++;
                      }
                      if (color == const Color.fromRGBO(191, 191, 191, 1)) {
                        _neutralDaysCount++;
                      }
                    }
                    _saveMarkedDates();
                  });
                  Navigator.of(context).pop();
                },
                onDialogClosed: () {
                  widget.onDialogOpen(false);
                },
              ),
            ),
          ],
        );
      },
    ).then((_) {
      widget.onDialogOpen(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberOfWeeks = _calculateNumberOfWeeks(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(
          top: 118.h,
          left: 14.5.w,
          right: 14.5.w,
        ),
        child: Column(
          children: [
            Container(
              width: 346.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(5.r),
                  bottomLeft: Radius.circular(5.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildWeekDays(),
                  Gap(10.h),
                  _buildCalendar(numberOfWeeks),
                  Gap(3.h),
                ],
              ),
            ),
            Gap(20.h),
            Container(
              height: 62.h,
              width: 346.w,
              padding: EdgeInsets.symmetric(horizontal: 14.5.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCounterBox('Bad Days', _badDaysCount,
                      const Color.fromRGBO(198, 0, 0, 1)),
                  _buildCounterBox('Good Days', _goodDaysCount,
                      const Color.fromRGBO(0, 179, 61, 1)),
                  _buildCounterBox('Neutral Days', _neutralDaysCount,
                      const Color.fromRGBO(191, 191, 191, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateNumberOfWeeks(DateTime date) {
    int year = date.year;
    int month = date.month;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int firstWeekdayOfMonth = (firstDayOfMonth.weekday + 6) % 7;
    int numberOfDaysInMonth = DateTime(year, month + 1, 0).day;
    return ((firstWeekdayOfMonth + numberOfDaysInMonth) / 7).ceil();
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/icons/prev_icon.png',
            width: 30.r,
            height: 30.r,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _selectedDate =
                  DateTime(_selectedDate.year, _selectedDate.month - 1);
            });
          },
        ),
        Text(
          DateFormat.yMMMM().format(_selectedDate),
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w700,
            fontSize: 20.r,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: Image.asset(
            'assets/icons/next_icon.png',
            width: 30.r,
            height: 30.r,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _selectedDate =
                  DateTime(_selectedDate.year, _selectedDate.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekDays
            .map((day) => Text(
                  day,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendar(int numberOfWeeks) {
    int year = _selectedDate.year;
    int month = _selectedDate.month;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int firstWeekdayOfMonth = (firstDayOfMonth.weekday + 6) % 7;
    int numberOfDaysInMonth = DateTime(year, month + 1, 0).day;

    DateTime lastMonth = DateTime(year, month - 1);
    int numberOfDaysInLastMonth =
        DateTime(lastMonth.year, lastMonth.month + 1, 0).day;

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      int day = numberOfDaysInLastMonth - firstWeekdayOfMonth + i + 1;
      dayCells.add(
          _buildDayCell(DateTime(lastMonth.year, lastMonth.month, day), true));
    }

    for (int i = 1; i <= numberOfDaysInMonth; i++) {
      dayCells.add(_buildDayCell(DateTime(year, month, i), false));
    }

    int remainingCells = numberOfWeeks * 7 - dayCells.length;
    for (int i = 1; i <= remainingCells; i++) {
      dayCells.add(_buildDayCell(DateTime(year, month + 1, i), true));
    }

    return Container(
      height: numberOfWeeks * 48.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < numberOfWeeks; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dayCells.skip(i * 7).take(7).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildDayCell(DateTime day, bool isFaded) {
    return GestureDetector(
      onTap: !isFaded ? () => _onDaySelected(day) : null,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: _markedDates[day],
          border: Border.all(
            color: isFaded ? Colors.transparent : Colors.white.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(5.r),
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(18.r),
          ),
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounterBox(String label, int count, Color color) {
    return Container(
      width: 100.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
        child: Text(
          '$count',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ColorSelectionDialog extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<Color> onColorSelected;
  final VoidCallback onDialogClosed;

  const ColorSelectionDialog({
    required this.selectedDate,
    required this.onColorSelected,
    required this.onDialogClosed,
  });

  @override
  _ColorSelectionDialogState createState() => _ColorSelectionDialogState();
}

class _ColorSelectionDialogState extends State<ColorSelectionDialog> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 380.w,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ClipRRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(170.h),
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
                    widget.onDialogClosed();
                  },
                ),
              ),
              Gap(10.h),
              Text(
                'Choose a colour for this day!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Gap(30.h),
              Text(
                ("${DateFormat('d MMMM').format(widget.selectedDate)}:"),
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w500,
                  fontSize: 24.sp,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Gap(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: _buildColorOption(
                      const Color.fromRGBO(198, 0, 0, 1),
                      'Bad day',
                      const Color.fromRGBO(198, 0, 0, 1),
                      const Color.fromRGBO(198, 0, 0, 0.4),
                      const Color.fromRGBO(198, 0, 0, 1),
                    ),
                  ),
                  Gap(10.w),
                  Flexible(
                    child: _buildColorOption(
                      const Color.fromRGBO(0, 179, 61, 1),
                      'Good day',
                      const Color.fromRGBO(0, 179, 61, 1),
                      const Color.fromRGBO(0, 179, 61, 0.4),
                      const Color.fromRGBO(0, 179, 61, 1),
                    ),
                  ),
                  Gap(10.w),
                  Flexible(
                    child: _buildColorOption(
                      const Color.fromRGBO(191, 191, 191, 1),
                      'Neutral day',
                      const Color.fromRGBO(191, 191, 191, 1),
                      const Color.fromRGBO(191, 191, 191, 0.4),
                      const Color.fromRGBO(191, 191, 191, 1),
                    ),
                  ),
                ],
              ),
              Gap(30.h),
              ElevatedButton(
                onPressed: () {
                  if (_selectedColor != null) {
                    widget.onColorSelected(_selectedColor!);
                  }
                },
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
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: _selectedColor != null
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, String label, Color selectedColor,
      Color unselectedColor, Color shadowColor) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(0, 0),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 15.r,
              color: Colors.white,
              height: 1.h,
            ),
          ),
        ),
      ),
    );
  }
}
