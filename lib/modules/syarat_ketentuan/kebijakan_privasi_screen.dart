import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/data/network/api_endpoints.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KebijakanPrivasiScreen extends StatefulWidget {
  const KebijakanPrivasiScreen({Key? key}) : super(key: key);

  @override
  State<KebijakanPrivasiScreen> createState() => _KebijakanPrivasiScreenState();
}

class _KebijakanPrivasiScreenState extends State<KebijakanPrivasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
        ),
      ),
      body: WebView(
        initialUrl: Uri.http(ApiEndpoints.baseUrl, ApiEndpoints.privacyPolicy)
            .toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
