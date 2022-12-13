import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/duration.dart';
import 'package:plj_absensi_mobile/modules/akun/akun_saya_screen.dart';
import 'package:plj_absensi_mobile/modules/home/home_screen.dart';
import 'package:plj_absensi_mobile/modules/kontak/kontak_screen.dart';
import 'package:plj_absensi_mobile/modules/presensi/presensi_screen.dart';
import 'package:plj_absensi_mobile/modules/presensi/presensi_success_screen.dart';
import 'package:plj_absensi_mobile/modules/signin/signin_screen.dart';
import 'package:plj_absensi_mobile/modules/splash/splash_screen.dart';
import 'package:plj_absensi_mobile/modules/syarat_ketentuan/kebijakan_privasi_screen.dart';
import 'package:plj_absensi_mobile/modules/syarat_ketentuan/syarat_ketentuan_screen.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';

class AppPages {
  static final pages = [
    // * AUTH
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.signInScreen,
      page: () => const SignInScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    // * HOME
    GetPage(
      name: RouteNames.homeScreen,
      page: () => const HomeScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    // * Presensi & Kehadiran
    GetPage(
      name: RouteNames.presensiScreen,
      page: () => const PresensiScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    GetPage(
      name: RouteNames.presensiSuccessScreen,
      page: () => const PresensiSuccessScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    // GetPage(
    //   name: RouteNames.detailPresensiScreen,
    //   page: () => const DetailPresensiScreen(),
    //   curve: Curves.easeInOut,
    //   transition: Transition.rightToLeft,
    //   transitionDuration: defaultDuration,
    // ),
    // * AKUN SAYA
    GetPage(
      name: RouteNames.akunSayaScreen,
      page: () => const AkunSayaScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    // GetPage(
    //   name: RouteNames.editPasswordScreen,
    //   page: () => const EditPasswordScreen(),
    //   curve: Curves.easeInOut,
    //   transition: Transition.rightToLeft,
    //   transitionDuration: defaultDuration,
    // ),
    // GetPage(
    //   name: RouteNames.editPasswordSuccessScreen,
    //   page: () => const EditPasswordSuccessScreen(),
    //   curve: Curves.easeInOut,
    //   transition: Transition.rightToLeft,
    //   transitionDuration: defaultDuration,
    // ),
    GetPage(
      name: RouteNames.syaratKetentuanScreen,
      page: () => const SyaratKetentuanScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    GetPage(
      name: RouteNames.kebijakanPrivasiScreen,
      page: () => const KebijakanPrivasiScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    GetPage(
      name: RouteNames.kontakKamiScreen,
      page: () => const KontakScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
      transitionDuration: defaultDuration,
    ),
    // * Dalam Pengembangan
    // GetPage(
    //   name: RouteNames.dalamPengembanganScreen,
    //   page: () => const DalamPengembanganScreen(),
    //   curve: Curves.easeInOut,
    //   transition: Transition.rightToLeft,
    //   transitionDuration: defaultDuration,
    // ),
  ];
}
