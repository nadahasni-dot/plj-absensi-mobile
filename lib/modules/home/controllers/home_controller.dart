import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/modules/home/pages/akun_page.dart';
import 'package:plj_absensi_mobile/modules/home/pages/beranda_page.dart';

class HomeController extends GetxController {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  Widget _displayWidget = const BerandaPage();

  Widget get displayWidget => _displayWidget;

  switchPage(int index) {
    _currentPageIndex = index;

    switch (index) {
      case 0:
        _displayWidget = const BerandaPage();
        break;
      case 2:
        _displayWidget = const AkunPage();
        break;
      default:
        _displayWidget = const BerandaPage();
    }

    update();
  }
}
