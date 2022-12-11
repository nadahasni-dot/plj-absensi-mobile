import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SyaratKetentuanScreen extends StatefulWidget {
  const SyaratKetentuanScreen({Key? key}) : super(key: key);

  @override
  State<SyaratKetentuanScreen> createState() => _SyaratKetentuanScreenState();
}

class _SyaratKetentuanScreenState extends State<SyaratKetentuanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        title: const Text('Syarat dan Ketentuan'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
        ),
      ),
      body: WebView(
        initialUrl: Uri.https('google.com').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
