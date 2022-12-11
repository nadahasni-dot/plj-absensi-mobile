import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class ImageSelector {
  static showImagePicker(
      {required Function() onGallery, required Function onCamera}) {
    Get.bottomSheet(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Get.back();
              onGallery();
            },
            title: const Text(
              'Ambil dari galeri',
              style: TextStyle(fontFamily: 'inter'),
            ),
            leading: const Icon(Icons.image),
          ),
          ListTile(
            onTap: () {
              Get.back();
              onCamera();
            },
            title: const Text(
              'Ambil dari kamera',
              style: TextStyle(fontFamily: 'inter'),
            ),
            leading: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      backgroundColor: white,
    );
  }
}
