import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/illustrations/ilustrasi-fitur-dalam-tahap-pengembangan.png',
                width: 200,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Fitur Dalam Tahap Pengembangan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Fitur ini masih dalam tahap pengembangan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textDarkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
