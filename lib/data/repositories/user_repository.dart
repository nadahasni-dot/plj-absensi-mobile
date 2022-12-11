import 'dart:developer';
import 'dart:io';

import 'package:plj_absensi_mobile/data/models/profile_model.dart';
import 'package:plj_absensi_mobile/data/models/user_model.dart';
import 'package:plj_absensi_mobile/data/network/api_endpoints.dart';
import 'package:plj_absensi_mobile/data/network/network_service.dart';

class UserRepository {
  static Future<UserModel> getProfile() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.profile,
        {},
        null,
        withToken: true,
      );
      log(response.toString(), name: 'AUTH REPOSITORY');

      return ProfileModel.fromJson(response).data;
    } catch (e) {
      log('ERROR GET PROFILE: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }

  static Future<bool> updateAvatar(File avatar) async {
    try {
      final response = await NetworkService.postWithImage(
        ApiEndpoints.baseUrl,
        ApiEndpoints.updateAvatar,
        {},
        avatar,
        'avatar',
        withToken: true,
        headers: {},
      );
      log(response.toString(), name: 'AUTH REPOSITORY');

      return true;
    } catch (e) {
      log('ERROR UPDATE AVATAR: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }

  static Future<bool> updateProfile({required String name}) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.profile,
        {},
        {'name': name},
        withToken: true,
      );
      log(response.toString(), name: 'AUTH REPOSITORY');

      return true;
    } catch (e) {
      log('ERROR UPDATE PROFILE: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }

  static Future<bool> updatepassword(
      String oldPassword, String password) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.updatePassword,
        {},
        {
          'old_password': oldPassword,
          'password': password,
          'password_confirmation': password,
        },
        withToken: true,
      );
      log(response.toString(), name: 'AUTH REPOSITORY');

      return true;
    } catch (e) {
      log('ERROR UPDATE PASSWORD: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }
}
