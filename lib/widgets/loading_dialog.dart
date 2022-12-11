import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Lottie.asset('assets/lottie/loading.json', height: 80),
          ),
        ),
      ),
    );
  }
}
