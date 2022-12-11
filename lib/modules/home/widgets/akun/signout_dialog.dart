import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

import '../../../../widgets/primary_button.dart';
import '../../../../widgets/custom_outlined_button.dart';

class SignoutDialog extends StatelessWidget {
  const SignoutDialog({
    Key? key,
    required this.onSignout,
  }) : super(key: key);

  final VoidCallback onSignout;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Keluar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: textDarkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Apakah Anda yakin untuk keluar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textDarkGreyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: onSignout,
                  label: 'Ya',
                  isDense: true,
                  color: errorColor,
                ),
                const SizedBox(height: 8),
                CustomOutlinedButton(
                  onPressed: () => Get.back(),
                  label: 'Batal',
                  isDense: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
