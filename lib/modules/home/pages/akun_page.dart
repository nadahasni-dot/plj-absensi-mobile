import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/akun/akun_page_loading.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/akun/profile_avatar.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/akun/profile_menu.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/akun/signout_dialog.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';
import 'package:plj_absensi_mobile/utilities/image_selector.dart';
import 'package:plj_absensi_mobile/widgets/error_page_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();

    if (_profileController.profileCall.value.status == Status.iddle) {
      _profileController.getProfile();
    }
  }

  Future<void> _onRefresh() async {
    await _profileController.getProfile();
  }

  void _changeProfileAvatar() {
    ImageSelector.showImagePicker(
      onCamera: _onCamera,
      onGallery: _onGallery,
    );
  }

  void _doSignOut() {
    Get.dialog(SignoutDialog(
      onSignout: () => _profileController.logout(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(title: const Text('Akun')),
        Expanded(
          child: Obx(() {
            if (_profileController.profileCall.value.status == Status.iddle) {
              return const AkunPageLoading();
            }
            if (_profileController.profileCall.value.status == Status.loading) {
              return const AkunPageLoading();
            }
            if (_profileController.profileCall.value.status == Status.error) {
              return ErrorPageBuilder(
                error: _profileController.profileCall.value.message!,
                onPressed: _onRefresh,
              );
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileAvatar(
                      image: _profileController.user!.avatar,
                      onTap: _changeProfileAvatar,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _profileController.user!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Pegawai',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 32),
                    ProfileMenu(
                      label: 'Akun Saya',
                      icon: 'assets/icons/akun-saya.svg',
                      onTap: () => Get.toNamed(RouteNames.akunSayaScreen),
                    ),
                    // const SizedBox(height: 8),
                    // ProfileMenu(
                    //   label: 'Edit password',
                    //   icon: 'assets/icons/edit-password.svg',
                    //   onTap: () => Get.toNamed(RouteNames.editPasswordScreen),
                    // ),
                    const SizedBox(height: 8),
                    ProfileMenu(
                      label: 'Syarat dan Ketentuan',
                      icon: 'assets/icons/syarat-ketentuan.svg',
                      onTap: () =>
                          Get.toNamed(RouteNames.syaratKetentuanScreen),
                    ),
                    const SizedBox(height: 8),
                    ProfileMenu(
                      label: 'Kebijakan Privasi',
                      icon: 'assets/icons/kebijakan-privasi.svg',
                      onTap: () =>
                          Get.toNamed(RouteNames.kebijakanPrivasiScreen),
                    ),
                    const SizedBox(height: 8),
                    ProfileMenu(
                      label: 'Kontak Kami',
                      icon: 'assets/icons/kontak-kami.svg',
                      onTap: () => Get.toNamed(RouteNames.kontakKamiScreen),
                    ),
                    const SizedBox(height: 8),
                    ProfileMenu(
                      onTap: () {},
                      label: 'Versi Aplikasi',
                      icon: 'assets/icons/versi-aplikasi.svg',
                      suffix: const Text(
                        '1.0.0-rc',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ProfileMenu(
                      onTap: _doSignOut,
                      icon: 'assets/icons/keluar.svg',
                      label: 'Keluar',
                    ),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  void _onCamera() async {
    final file = await pickImage(ImageSource.camera);

    if (file == null) return;

    _updateAvatar(file);
  }

  void _onGallery() async {
    final file = await pickImage(ImageSource.gallery);

    if (file == null) return;

    _updateAvatar(file);
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 30);

      if (image == null) {
        return null;
      }

      File? imageTemp;

      if (source == ImageSource.camera) {
        imageTemp = await saveImagePermanently(image.path);
      } else {
        imageTemp = File(image.path);
      }

      if (source == ImageSource.gallery) {
        final size = imageTemp.readAsBytesSync().lengthInBytes;
        final kb = size / 1024;

        if (kb > 2048) {
          Fluttertoast.showToast(msg: 'Ukuran foto tidak boleh lebih dari 2MB');
          return null;
        }
      }

      return imageTemp;
    } on PlatformException catch (e) {
      log('failed pick image: ${e.toString()}');
      return null;
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationSupportDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  void _updateAvatar(file) {
    _profileController.updateAvatar(file);
  }
}
