import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/helpers/date_format.dart';
import 'package:plj_absensi_mobile/helpers/time_helper.dart';

import 'time_item.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({
    super.key,
    required this.onTap,
    this.inTime,
    this.outTime,
    this.status,
  });

  final VoidCallback onTap;
  final DateTime? inTime;
  final DateTime? outTime;
  final String? status;

  String showInTime() {
    if (inTime == null) return '--:--:--';
    return dateFormatHourMinuteSecs.format(inTime!);
  }

  String showOutTime() {
    if (outTime == null) return '--:--:--';
    return dateFormatHourMinuteSecs.format(outTime!);
  }

  String showTotalTime() {
    if (inTime == null) return '--:--:--';
    if (outTime == null) return '--:--:--';

    return calculateTotalTime(inTime!, outTime!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: defaultBorder,
      child: Ink(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [defaultShadow],
          borderRadius: defaultBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              dateFormatDayName.format(DateTime.now()),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimeItem(
                  icon: status == 'NOTPRESENT'
                      ? 'assets/icons/icon-tidak-hadir.svg'
                      : 'assets/icons/presensi-masuk.svg',
                  time: showInTime(),
                  label: 'Presensi\nMasuk',
                ),
                TimeItem(
                  icon: status == 'NOTPRESENT'
                      ? 'assets/icons/icon-tidak-hadir.svg'
                      : 'assets/icons/presensi-pulang.svg',
                  time: showOutTime(),
                  label: 'Presensi\nPulang',
                ),
                TimeItem(
                  icon: status == 'NOTPRESENT'
                      ? 'assets/icons/icon-tidak-hadir.svg'
                      : 'assets/icons/jam-kerja.svg',
                  time: showTotalTime(),
                  label: 'Jam\nKerja',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
