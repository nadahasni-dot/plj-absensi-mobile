import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/nav_item.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';

import '../controllers/home_controller.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavItem(
            index: 0,
            label: 'Riwayat',
            icon: 'assets/icons/beranda.svg',
            activeIcon: 'assets/icons/beranda-active.svg',
            onTap: (index) => _homeController.switchPage(index),
          ),
          NavItem(
            index: 1,
            label: 'Presensi',
            icon: 'assets/icons/scan-qr.svg',
            activeIcon: 'assets/icons/scan-qr.svg',
            onTap: (index) => Get.toNamed(RouteNames.presensiScreen),
          ),
          NavItem(
            index: 2,
            label: 'Akun',
            icon: 'assets/icons/akun.svg',
            activeIcon: 'assets/icons/akun-active.svg',
            onTap: (index) => _homeController.switchPage(index),
          ),
        ],
      ),
    );
  }
}
