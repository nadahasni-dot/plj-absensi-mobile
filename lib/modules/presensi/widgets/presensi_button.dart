import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class PresensiButton extends StatelessWidget {
  const PresensiButton({
    Key? key,
    required this.onTap,
    required this.isPresensiMasuk,
    this.isEnabled = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isEnabled;
  final bool isPresensiMasuk;

  BoxShadow _getShadow() {
    if (!isEnabled) {
      return BoxShadow(
        color: black.withOpacity(0.15),
        blurRadius: 50,
        spreadRadius: -2,
        offset: const Offset(0, 25),
      );
    }

    if (isPresensiMasuk) {
      return BoxShadow(
        color: const Color(0xFF4DC518).withOpacity(0.15),
        blurRadius: 50,
        spreadRadius: -2,
        offset: const Offset(0, 25),
      );
    }

    return BoxShadow(
      color: const Color(0xFFE74C3C).withOpacity(0.15),
      blurRadius: 50,
      spreadRadius: -2,
      offset: const Offset(0, 25),
    );
  }

  LinearGradient _getGradient() {
    if (!isEnabled) {
      return const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFFA3A3A3),
          Color(0xFFD9D9D9),
        ],
      );
    }

    if (isPresensiMasuk) {
      return const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFF009E49),
          Color(0xFF4DC518),
        ],
      );
    }

    return const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFC44133),
        Color(0xFFF29D94),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(200),
        child: Ink(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _getGradient(),
            boxShadow: [_getShadow()],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/icon-touch.svg'),
              const SizedBox(height: 12),
              Text(
                isPresensiMasuk ? 'Presensi Masuk' : 'Presensi Pulang',
                style: const TextStyle(
                  fontSize: 18,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
