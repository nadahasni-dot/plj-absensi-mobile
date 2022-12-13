import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/helpers/date_format.dart';
import 'package:plj_absensi_mobile/helpers/time_helper.dart';
import 'package:plj_absensi_mobile/utilities/responsive_util.dart';

class PresensiTime extends StatelessWidget {
  const PresensiTime({
    Key? key,
    this.inTime,
    this.outTime,
  }) : super(key: key);

  final DateTime? inTime;
  final DateTime? outTime;

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
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: defaultBorder,
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/icons/presensi-masuk.svg'),
                const SizedBox(height: 10),
                Text(
                  showInTime(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Presensi Masuk',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveUtil(context).byWidth * 13,
                    color: textDarkGreyColor,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: defaultBorder,
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/icons/presensi-pulang.svg'),
                const SizedBox(height: 10),
                Text(
                  showOutTime(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Presensi Pulang',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveUtil(context).byWidth * 13,
                    color: textDarkGreyColor,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: defaultBorder,
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/icons/jam-kerja.svg'),
                const SizedBox(height: 10),
                Text(
                  showTotalTime(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Jam Kerja',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveUtil(context).byWidth * 13,
                    color: textDarkGreyColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
