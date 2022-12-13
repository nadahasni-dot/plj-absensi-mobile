import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/data/models/attendance_model.dart';
import 'package:plj_absensi_mobile/data/models/schedule_model.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/data/repositories/attendance_repository.dart';
import 'package:plj_absensi_mobile/widgets/loading_dialog.dart';

class AttendanceController extends GetxController {
  Rx<ResponseCall> scheduleCall = ResponseCall.iddle('iddle').obs;
  ScheduleModel? schedule;

  Rx<ResponseCall> attendanceCall = ResponseCall.iddle('iddle').obs;
  RxList<AttendanceModel> attendances = <AttendanceModel>[].obs;

  Rx<ResponseCall> attendanceDetailCall = ResponseCall.iddle('iddle').obs;
  AttendanceModel? attendanceDetail;

  AttendanceModel? getTodayAttendance() {
    final attendance = attendances.firstWhereOrNull((element) {
      final now = DateTime.now();
      return (element.clockIn?.year == now.year &&
          element.clockIn?.month == now.month &&
          element.clockIn?.day == now.day);
    });

    return attendance;
  }

  Future<bool> getSchedule() async {
    scheduleCall(ResponseCall.loading('loading'));
    try {
      schedule = await AttendanceRepository.getSchedule();
      scheduleCall(ResponseCall.completed('completed'));
      return true;
    } catch (e) {
      log('ERROR GET SCHEDULE: ${e.toString()}', name: 'ATTENDANCE CONTROLLER');
      scheduleCall(ResponseCall.error(e.toString()));
      return false;
    }
  }

  Future<bool> getAttendanceDetail(int id) async {
    attendanceDetailCall(ResponseCall.loading('loading'));
    try {
      attendanceDetail = await AttendanceRepository.getAttendanceDetail(id);
      attendanceDetailCall(ResponseCall.completed('completed'));
      return true;
    } catch (e) {
      log('ERROR GET ATTENDANCE DETAIL: ${e.toString()}',
          name: 'ATTENDANCE CONTROLLER');
      attendanceDetailCall(ResponseCall.error(e.toString()));
      return false;
    }
  }

  Future<bool> getAttendances() async {
    attendanceCall(ResponseCall.loading('loading'));
    try {
      final response = await AttendanceRepository.getAttendances();

      attendances.clear();
      attendances.addAll(response);

      attendanceCall(ResponseCall.completed('completed'));
      return true;
    } catch (e) {
      log('ERROR GET ATTENDANCES: ${e.toString()}',
          name: 'ATTENDANCE CONTROLLER');
      attendanceCall(ResponseCall.error(e.toString()));
      return false;
    }
  }

  Future<bool> submitAttendance({required bool isIn}) async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);

    try {
      await AttendanceRepository.postAttendance(isIn: isIn);

      getAttendances();

      Get.until((route) => !Get.isDialogOpen!);
      return true;
    } catch (e) {
      log('ERROR SUBMIT ATTENDANCE: ${e.toString()}',
          name: 'ATTENDANCE CONTROLLER');
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      Get.until((route) => !Get.isDialogOpen!);
      return false;
    }
  }
}
