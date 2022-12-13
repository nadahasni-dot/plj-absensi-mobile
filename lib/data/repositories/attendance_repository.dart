import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:plj_absensi_mobile/data/models/attendance_model.dart';
import 'package:plj_absensi_mobile/data/models/schedule_model.dart';
import 'package:plj_absensi_mobile/data/network/api_endpoints.dart';
import 'package:plj_absensi_mobile/data/network/network_service.dart';

class AttendanceRepository {
  static Future<ScheduleModel> getSchedule() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.schedule,
        {},
        null,
        withToken: true,
      );
      log(response.toString(), name: 'ATTENDANCE REPOSITORY');

      return ScheduleResponse.fromJson(response).data;
    } catch (e) {
      log('ERROR GET SCHEDULE: ${e.toString()}', name: 'ATTENDANCE REPOSITORY');
      rethrow;
    }
  }

  static Future<List<AttendanceModel>> getAttendances() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.attendance,
        {},
        null,
        withToken: true,
      );
      log(response.toString(), name: 'ATTENDANCES REPOSITORY');

      return AttendanceResponse.fromJson(response).data;
    } catch (e) {
      log('ERROR GET ATTENDANCES: ${e.toString()}',
          name: 'ATTENDANCES REPOSITORY');
      rethrow;
    }
  }

  static Future<AttendanceModel> getAttendanceDetail(int attendanceId) async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.attendanceDetail(attendanceId),
        {},
        null,
        withToken: true,
      );
      log(response.toString(), name: 'ATTENDANCE REPOSITORY');

      return AttendanceModel.fromJson(response['data']);
    } catch (e) {
      log('ERROR GET ATTENDANCE DETAIL: ${e.toString()}',
          name: 'ATTENDANCE REPOSITORY');
      rethrow;
    }
  }

  static Future<bool> postAttendance({
    required bool isIn,
  }) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.attendance,
        {},
        {
          'type': isIn ? 'IN' : 'OUT',
        },
        withToken: true,
      );
      log(response.toString(), name: 'ATTENDANCE REPOSITORY');

      if (response['success'] == true) {
        return true;
      }

      Fluttertoast.showToast(msg: response['message']);
      return false;
    } catch (e) {
      log('ERROR POST ATTENDANCE: ${e.toString()}',
          name: 'ATTENDANCE REPOSITORY');
      rethrow;
    }
  }
}
