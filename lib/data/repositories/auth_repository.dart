import 'dart:developer';

import 'package:plj_absensi_mobile/data/local/session.dart';
import 'package:plj_absensi_mobile/data/models/login_model.dart';
import 'package:plj_absensi_mobile/data/models/user_model.dart';
import 'package:plj_absensi_mobile/data/network/api_endpoints.dart';
import 'package:plj_absensi_mobile/data/network/network_service.dart';

class AuthRepository {
  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.login,
        {},
        {
          'email': email,
          'password': password,
        },
      );
      log(response.toString(), name: 'AUTH REPOSITORY');

      final result = LoginModel.fromJson(response);
      await Session.saveSession(result.token);
      return result.data;
    } catch (e) {
      log('ERROR LOGIN: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }

  static Future<bool> logout() async {
    try {
      await Session.clearSession();

      return true;
    } catch (e) {
      log('ERROR LOGOUT: ${e.toString()}', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }
}
