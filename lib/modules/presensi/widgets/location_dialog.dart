import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/widgets/custom_outlined_button.dart';
import 'package:plj_absensi_mobile/widgets/primary_button.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({Key? key}) : super(key: key);

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
                  'Lokasi Diperlukan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: textDarkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Harap aktifkan layanan lokasi (GPS) anda ke mode "akurat" untuk melanjutkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textDarkGreyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {
                    Get.until((route) => !Get.isDialogOpen!);
                    Geolocator.openLocationSettings();
                  },
                  label: 'Aktifkan Lokasi',
                  isDense: true,
                ),
                const SizedBox(height: 8),
                CustomOutlinedButton(
                  onPressed: () => Get.back(),
                  label: 'Tidak',
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
