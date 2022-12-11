import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/home/controllers/home_controller.dart';
import 'package:plj_absensi_mobile/modules/home/widgets/home/time_card_loading.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';
import 'package:plj_absensi_mobile/widgets/shimmer_wrapper.dart';

class BerandaTopSection extends StatefulWidget {
  const BerandaTopSection({Key? key}) : super(key: key);

  @override
  State<BerandaTopSection> createState() => _BerandaTopSectionState();
}

class _BerandaTopSectionState extends State<BerandaTopSection> {
  final now = DateTime.now();
  final _homeController = Get.find<HomeController>();
  final _profileController = Get.find<ProfileController>();
  // final _attendanceController = Get.find<AttendanceController>();

  StreamSubscription? listenProfileCall;

  @override
  void initState() {
    super.initState();

    if (_profileController.profileCall.value.status == Status.iddle) {
      _profileController.getProfile();
    }

    // if (_attendanceController.workTimeCall.value.status == Status.iddle) {
    //   _attendanceController.getWorkTime();
    // }

    // if (_attendanceController.attendanceCall.value.status == Status.iddle) {
    //   final latestPeriod = getLatestPeriod()[0];
    //   _attendanceController.getAttendances(
    //     start: latestPeriod.startDate,
    //     end: latestPeriod.endDate,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const BoxDecoration(
        color: white,
        image: DecorationImage(
          image: AssetImage('assets/images/home-bg.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(() {
                          if (_profileController.profileCall.value.status !=
                              Status.completed) {
                            return Row(
                              children: [
                                ShimmerWrapper(
                                  child: Container(
                                    height: 14,
                                    width: 100,
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: neutralColor,
                                      borderRadius: smallBorder,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return const Text(
                            'Selamat Datang,',
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                            ),
                          );
                        }),
                        Obx(() {
                          if (_profileController.profileCall.value.status !=
                              Status.completed) {
                            return Row(
                              children: [
                                ShimmerWrapper(
                                  child: Container(
                                    height: 20,
                                    width: 200,
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: neutralColor,
                                      borderRadius: smallBorder,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return Text(
                            _profileController.user!.name,
                            style: const TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(46),
                    child: Obx(() {
                      if (_profileController.profileCall.value.status !=
                          Status.completed) {
                        return Row(
                          children: [
                            ShimmerWrapper(
                              child: Container(
                                height: 46,
                                width: 46,
                                color: neutralColor,
                              ),
                            ),
                          ],
                        );
                      }

                      return GestureDetector(
                        onTap: () => _homeController.switchPage(4),
                        child: Builder(builder: (context) {
                          if (_profileController.user?.avatar != null) {
                            return CachedNetworkImage(
                              imageUrl: _profileController.user!.avatar!,
                              height: 46,
                              width: 46,
                              fit: BoxFit.cover,
                            );
                          }

                          return Image.asset(
                            'assets/images/placeholder-akun.jpg',
                            height: 46,
                            width: 46,
                            fit: BoxFit.cover,
                          );
                        }),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Builder(builder: (context) {
                return const TimeCardLoading();
                // if (_attendanceController.workTimeCall.value.status ==
                //     Status.iddle) {
                //   return const TimeCardLoading();
                // }

                // if (_attendanceController.workTimeCall.value.status ==
                //     Status.loading) {
                //   return const TimeCardLoading();
                // }

                // if (_attendanceController.workTimeCall.value.status ==
                //     Status.error) {
                //   return TimeCard(
                //     onTap: _openPresensiKehadiran,
                //     inTime: null,
                //     outTime: null,
                //   );
                // }

                // if (_attendanceController.attendanceCall.value.status ==
                //     Status.iddle) {
                //   return const TimeCardLoading();
                // }

                // if (_attendanceController.attendanceCall.value.status ==
                //     Status.loading) {
                //   return const TimeCardLoading();
                // }

                // if (_attendanceController.attendanceCall.value.status ==
                //     Status.error) {
                //   return TimeCard(
                //     onTap: _openPresensiKehadiran,
                //     inTime: null,
                //     outTime: null,
                //   );
                // }

                // if (_attendanceController.attendances.isEmpty) {
                //   return TimeCard(
                //     onTap: _openPresensiKehadiran,
                //     inTime: null,
                //     outTime: null,
                //   );
                // }

                // if (_attendanceController.getTodayAttendance() == null) {
                //   return TimeCard(
                //     onTap: _openPresensiKehadiran,
                //     inTime: null,
                //     outTime: null,
                //   );
                // }

                // final todayAttendance =
                //     _attendanceController.getTodayAttendance()!;
                // return TimeCard(
                //   status: todayAttendance.status,
                //   onTap: _openPresensiKehadiran,
                //   inTime: todayAttendance.loginTime,
                //   outTime: todayAttendance.logoutTime,
                // );
              }),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _openPresensiKehadiran() => Get.toNamed(RouteNames.presensiScreen);
}
