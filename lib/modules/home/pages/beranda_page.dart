import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/home/beranda_top_section.dart';
import 'package:plj_absensi_mobile/modules/presensi/controllers/attendance_controller.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/riwayat_presensi_card.dart';
import 'package:plj_absensi_mobile/widgets/error_page_builder.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final _profileController = Get.find<ProfileController>();
  final _attendanceController = Get.find<AttendanceController>();

  Future<void> _onRefresh() async {
    await _profileController.getProfile();
    await _attendanceController.getSchedule();
    await _attendanceController.getAttendances();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 2,
            child: BerandaTopSection(),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 3,
            child: Obx(() {
              if (_attendanceController.scheduleCall.value.status ==
                  Status.iddle) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_attendanceController.scheduleCall.value.status ==
                  Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_attendanceController.scheduleCall.value.status ==
                  Status.error) {
                return ErrorPageBuilder(
                  error: _attendanceController.scheduleCall.value.message!,
                  onPressed: _onRefresh,
                );
              }

              if (_attendanceController.attendanceCall.value.status ==
                  Status.iddle) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_attendanceController.attendanceCall.value.status ==
                  Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_attendanceController.attendanceCall.value.status ==
                  Status.error) {
                return ErrorPageBuilder(
                  error: _attendanceController.attendanceCall.value.message!,
                  onPressed: _onRefresh,
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _attendanceController.attendances.length,
                itemBuilder: (context, index) {
                  final attendance = _attendanceController.attendances[index];

                  return RiwayatPresensiCard(
                    onTap: () {},
                    date: attendance.createdAt,
                    jamMasuk: attendance.clockIn,
                    jamPulang: attendance.clockOut,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
              );
            }),
          )
        ],
      ),
    );
  }
}
