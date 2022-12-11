import 'dart:developer';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/data/models/user_model.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/data/repositories/auth_repository.dart';
import 'package:plj_absensi_mobile/data/repositories/user_repository.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';
import 'package:plj_absensi_mobile/widgets/loading_dialog.dart';

class ProfileController extends GetxController {
  Rx<ResponseCall> profileCall = ResponseCall.iddle('iddle').obs;
  UserModel? user;

  Future<bool> getProfile() async {
    profileCall(ResponseCall.loading('loading'));
    try {
      user = await UserRepository.getProfile();
      profileCall(ResponseCall.completed('completed'));
      return true;
    } catch (e) {
      log('ERROR GET PROFILE: ${e.toString()}', name: 'PROFILE CONTROLLER');
      profileCall(ResponseCall.error(e.toString()));
      return false;
    }
  }

  Future<void> updateAvatar(File avatar) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    try {
      final isSuccess = await UserRepository.updateAvatar(avatar);
      Get.until((route) => !Get.isDialogOpen!);

      if (isSuccess) {
        getProfile();
      }
    } catch (e) {
      log('ERROR UPDATE AVATAR: ${e.toString()}', name: 'PROFILE CONTROLLER');
      Get.until((route) => !Get.isDialogOpen!);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateProfile({required String name}) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    try {
      final isSuccess = await UserRepository.updateProfile(name: name);
      Get.until((route) => !Get.isDialogOpen!);

      if (isSuccess) {
        getProfile();
        Get.until((route) => route.isFirst);
      }
    } catch (e) {
      log('ERROR UPDATE PROFILE: ${e.toString()}', name: 'PROFILE CONTROLLER');
      Get.until((route) => !Get.isDialogOpen!);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> updatePassword(String oldPassword, String password) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    try {
      final isSuccess =
          await UserRepository.updatepassword(oldPassword, password);
      Get.until((route) => !Get.isDialogOpen!);

      if (isSuccess) {
        return true;
      }

      return false;
    } catch (e) {
      log('ERROR UPDATE PASSWORD: ${e.toString()}', name: 'PROFILE CONTROLLER');
      Get.until((route) => !Get.isDialogOpen!);
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    try {
      final isSuccess = await AuthRepository.logout();
      Get.until((route) => !Get.isDialogOpen!);

      if (isSuccess) {
        Get.offAllNamed(RouteNames.signInScreen);
      }
    } catch (e) {
      log('ERROR GET PROFILE: ${e.toString()}', name: 'PROFILE CONTROLLER');
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
