import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/helpers/date_format.dart';

class RiwayatPresensiCard extends StatelessWidget {
  const RiwayatPresensiCard({
    Key? key,
    required this.onTap,
    required this.date,
    this.isPresence = true,
    this.isLate = false,
    this.presenceInfo,
    this.jamMasuk,
    this.jamPulang,
  }) : super(key: key);

  final VoidCallback onTap;
  final DateTime date;
  final bool isPresence;
  final bool isLate;
  final String? presenceInfo;
  final DateTime? jamMasuk;
  final DateTime? jamPulang;

  String _getJamKerja() {
    if (jamMasuk == null) return '--j --m';
    if (jamPulang == null) return '--j --m';

    final difference = jamPulang!.difference(jamMasuk!);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    String hour = hours < 10 ? '0$hours' : hours.toString();
    String minute = minutes < 10 ? '0$minutes' : minutes.toString();

    return '${hour}j ${minute}m';
  }

  Duration get duration {
    if (jamMasuk == null || jamPulang == null) {
      return const Duration(seconds: 0);
    }

    return jamPulang!.difference(jamMasuk!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: defaultBorder,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: white,
          borderRadius: defaultBorder,
          boxShadow: [defaultShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              dateFormatDayName.format(date),
              style: const TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            !isPresence
                ? Text(
                    '$presenceInfo',
                    style:
                        const TextStyle(fontSize: 14, color: textDarkGreyColor),
                  )
                : Row(
                    children: [
                      SvgPicture.asset(isLate
                          ? 'assets/icons/presensi-terlambat.svg'
                          : 'assets/icons/presensi-masuk.svg'),
                      const SizedBox(width: 8),
                      Text(
                        jamMasuk == null
                            ? '--:--:--'
                            : dateFormatHourMinuteSecs.format(jamMasuk!),
                        style: const TextStyle(
                            fontSize: 14, color: textDarkGreyColor),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/presensi-pulang.svg'),
                      const SizedBox(width: 8),
                      Text(
                        jamPulang == null
                            ? '--:--:--'
                            : dateFormatHourMinuteSecs.format(jamPulang!),
                        style: const TextStyle(
                            fontSize: 14, color: textDarkGreyColor),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/jam-kerja.svg'),
                      const SizedBox(width: 8),
                      Text(
                        _getJamKerja(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: textDarkGreyColor,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
