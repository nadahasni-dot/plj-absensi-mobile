import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class PhotoViewDialog extends StatelessWidget {
  const PhotoViewDialog({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Builder(builder: (context) {
            if (image.contains('assets/images')) {
              // load assets image
              return PhotoView(
                imageProvider: AssetImage(image),
              );
            }

            return PhotoView(
              imageProvider: CachedNetworkImageProvider(image),
            );
          }),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
              color: white,
            ),
          )
        ],
      ),
    );
  }
}
