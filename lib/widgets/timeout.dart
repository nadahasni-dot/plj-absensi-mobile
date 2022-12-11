import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

import 'small_button.dart';

class Timeout extends StatelessWidget {
  const Timeout({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

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
                'assets/illustrations/ilustrasi-error-504.png',
                width: 200,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Error 504',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Gateway Time Out',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textDarkGreyColor,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallButton(
                onPressed: onPressed,
                label: 'Muat Ulang',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
