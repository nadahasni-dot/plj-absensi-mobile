import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

enum LocationStatus { permissionDenied, sensorDisabled, outOfArea, inArea }

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key, required this.status}) : super(key: key);

  final LocationStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(builder: (context) {
          if (status == LocationStatus.sensorDisabled) {
            return SvgPicture.asset(
              'assets/icons/location-pin.svg',
              color: errorColor,
            );
          }

          if (status == LocationStatus.outOfArea) {
            return SvgPicture.asset(
              'assets/icons/location-pin.svg',
              color: errorColor,
            );
          }

          return SvgPicture.asset('assets/icons/location-pin.svg');
        }),
        const SizedBox(width: 6),
        Builder(builder: (context) {
          if (status == LocationStatus.permissionDenied) {
            return const Text(
              'Lokasi: Harap izinkan akses layanan GPS',
              style: TextStyle(color: errorColor),
            );
          }

          if (status == LocationStatus.sensorDisabled) {
            return const Text(
              'Lokasi: Harap aktifkan GPS anda',
              style: TextStyle(color: errorColor),
            );
          }

          if (status == LocationStatus.outOfArea) {
            return const Text(
              'Lokasi: Anda berada di luar area kantor',
              style: TextStyle(color: errorColor),
            );
          }

          return const Text(
            'Lokasi: Anda berada di area kantor',
            style: TextStyle(color: Color(0xFF508D1B)),
          );
        }),
      ],
    );
  }
}
