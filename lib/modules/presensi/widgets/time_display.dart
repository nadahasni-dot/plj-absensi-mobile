import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/helpers/date_format.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({Key? key, required this.onTimeChanged}) : super(key: key);
  final Function(DateTime time) onTimeChanged;

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  DateTime now = DateTime.now();
  late Timer _timer;

  void _playTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
        widget.onTimeChanged(now);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _playTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          dateFormatHourMinuteSecs.format(now),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 38,
            color: black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          dateFormatDayNameShort.format(now),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: textDarkGreyColor,
          ),
        ),
      ],
    );
  }
}
