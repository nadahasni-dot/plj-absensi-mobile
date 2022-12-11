import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/home/beranda_top_section.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final _profileController = Get.find<ProfileController>();
  // final _attendanceController = Get.find<AttendanceController>();

  Future<void> _onRefresh() async {
    await _profileController.getProfile();
    // await _attendanceController.getWorkTime();
    // await _attendanceController.getAttendances(
    //   start: latestPeriod.startDate,
    //   end: latestPeriod.endDate,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                BerandaTopSection(),
                SizedBox(height: 8),
              ],
            )
          ],
        ),
      ),
    );
  }
}
