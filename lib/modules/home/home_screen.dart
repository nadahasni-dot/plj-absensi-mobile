import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/constants/duration.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/home/controllers/home_controller.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _currentBackPressTime;

  @override
  void initState() {
    super.initState();
    Get.put(HomeController());
    Get.put(ProfileController());
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tekan kembali sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: GetBuilder<HomeController>(builder: (controller) {
          log('switch to page: ${controller.currentPageIndex}');

          return AnimatedSwitcher(
            duration: fastDuration,
            child: controller.displayWidget,
          );
        }),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
