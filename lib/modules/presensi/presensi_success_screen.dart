import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';
import 'package:plj_absensi_mobile/widgets/small_button.dart';

class PresensiSuccessScreen extends StatefulWidget {
  static const isPresensiMasuk = 'IS_PRESENSI_MASUK';
  const PresensiSuccessScreen({Key? key}) : super(key: key);

  @override
  State<PresensiSuccessScreen> createState() => _PresensiSuccessScreenState();
}

class _PresensiSuccessScreenState extends State<PresensiSuccessScreen> {
  bool isPresensiMasuk =
      Get.arguments[PresensiSuccessScreen.isPresensiMasuk] as bool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          width: 88,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isPresensiMasuk
                  ? 'assets/illustrations/ilustrasi-presensi-masuk-berhasil.png'
                  : 'assets/illustrations/ilustrasi-pulang.png',
              width: 250,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              isPresensiMasuk
                  ? 'Presensi Masuk Berhasil'
                  : 'Presensi Pulang Berhasil',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                isPresensiMasuk
                    ? 'Terima kasih telah melakukan presensi, selamat bekerja!'
                    : 'Terima kasih telah melakukan presensi, selamat beristirahat!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: textDarkGreyColor),
              ),
            ),
            const SizedBox(height: 32),
            SmallButton(onPressed: _navigateBack, label: 'Selesai'),
          ],
        ),
      ),
    );
  }

  _navigateBack() =>
      Get.until((route) => Get.currentRoute == RouteNames.homeScreen);
}
