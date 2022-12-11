import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

import 'small_button.dart';

class NoData extends StatelessWidget {
  const NoData({
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
                'assets/illustrations/ilustrasi-tidak-ada-data.png',
                width: 200,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tidak Ada Data',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Tidak ada data yang ditampilkan',
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
