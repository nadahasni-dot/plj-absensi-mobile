import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

import '../../../../widgets/primary_button.dart';
import '../../../../widgets/custom_outlined_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onConfirmation,
  }) : super(key: key);

  final String title;
  final String description;
  final VoidCallback onConfirmation;

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
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: textDarkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textDarkGreyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        onPressed: () => Get.back(),
                        label: 'Batal',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {
                          Get.back();
                          onConfirmation();
                        },
                        label: 'Ya',
                        isDense: true,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
