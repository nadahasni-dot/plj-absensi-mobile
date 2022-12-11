import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';

import 'constants/colors.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set default status bar color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // set system orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'id_ID';
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PLJ ABSENSI Mobile',
      theme: themeData,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.splashScreen,
    );
  }
}
