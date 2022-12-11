import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/utilities/image_selector.dart';

class SelectImageBox extends StatelessWidget {
  const SelectImageBox({
    Key? key,
    required this.file,
    required this.selectImageLabel,
    required this.reselectImageLabel,
    required this.onCamera,
    required this.onGallery,
    this.imageUrl,
    this.isCameraOnly = false,
  }) : super(key: key);

  final File? file;
  final String? imageUrl;
  final String selectImageLabel;
  final String reselectImageLabel;
  final bool isCameraOnly;
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [8, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () {
          if (isCameraOnly) {
            onCamera();
            return;
          }

          ImageSelector.showImagePicker(
            onGallery: onGallery,
            onCamera: onCamera,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Builder(builder: (context) {
            if (imageUrl != null && file == null) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: double.infinity,
                          color: black.withOpacity(0.5),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt_rounded,
                                color: white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                reselectImageLabel,
                                style:
                                    const TextStyle(color: white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (file != null) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.file(
                      file!,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: double.infinity,
                          color: black.withOpacity(0.5),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt_rounded,
                                color: white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                reselectImageLabel,
                                style:
                                    const TextStyle(color: white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container(
              height: 180,
              color: mainLayerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectImageLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: primaryColor),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
