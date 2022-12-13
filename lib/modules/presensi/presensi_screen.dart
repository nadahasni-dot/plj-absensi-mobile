import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/data/network/response_call.dart';
import 'package:plj_absensi_mobile/helpers/date_format.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/modules/presensi/controllers/attendance_controller.dart';
import 'package:plj_absensi_mobile/modules/presensi/controllers/location_controller.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/location_info.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/presensi_button.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/presensi_time.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/time_display.dart';
import 'package:plj_absensi_mobile/widgets/error_page_builder.dart';

class PresensiScreen extends StatefulWidget {
  const PresensiScreen({Key? key}) : super(key: key);

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  final _profileController = Get.find<ProfileController>();
  final _locationController = Get.find<LocationController>();
  final _attendanceController = Get.find<AttendanceController>();

  StreamSubscription? _gpsStatusSubscription;
  StreamSubscription? _gpsPositionSubscription;

  bool isPresensiMasuk = true;
  bool isAllowAttendance = false;

  @override
  void initState() {
    super.initState();
    _listenLocationChanges();
  }

  @override
  void dispose() {
    super.dispose();
    if (_gpsStatusSubscription != null) {
      _gpsStatusSubscription?.cancel();
    }
    if (_gpsPositionSubscription != null) {
      _gpsPositionSubscription?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        title: const Text('Presensi'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
        ),
      ),
      body: Obx(() {
        if (_attendanceController.scheduleCall.value.status == Status.iddle) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_attendanceController.scheduleCall.value.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_attendanceController.attendanceCall.value.status == Status.iddle) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_attendanceController.attendanceCall.value.status ==
            Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_attendanceController.attendanceCall.value.status == Status.error) {
          return ErrorPageBuilder(
            error: _attendanceController.attendanceCall.value.message!,
            onPressed: _onRefresh,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              TimeDisplay(onTimeChanged: _onTimeChanged),
              const Spacer(flex: 3),
              Obx(() {
                _locationController.currentLocation.value;

                // ? jika sudah absen masuk / pulang
                final todayAttendance =
                    _attendanceController.getTodayAttendance();
                if (todayAttendance?.clockIn != null &&
                    todayAttendance?.clockOut != null) {
                  return Image.asset(
                    'assets/illustrations/ilustrasi-pulang-berhasil.png',
                    height: 250,
                  );
                }

                return PresensiButton(
                  onTap: _submitPresensi,
                  isEnabled: isAllowAttendance,
                  isPresensiMasuk: isPresensiMasuk,
                );
              }),
              const Spacer(flex: 3),
              Obx(() {
                _locationController.currentLocation.value;

                LocationStatus status = LocationStatus.inArea;

                if (_locationController.locationPermission.value ==
                    LocationPermission.denied) {
                  status = LocationStatus.permissionDenied;
                }

                if (_locationController.locationPermission.value ==
                    LocationPermission.deniedForever) {
                  status = LocationStatus.permissionDenied;
                }

                if (!_locationController.isGpsEnabled.value) {
                  status = LocationStatus.sensorDisabled;
                }

                if (!_locationController.isInArea.value) {
                  status = LocationStatus.outOfArea;
                }

                return LocationInfo(status: status);
              }),
              const Spacer(flex: 2),
              if (_attendanceController.getTodayAttendance()?.clockIn == null ||
                  _attendanceController.getTodayAttendance()?.clockOut == null)
                Text(
                  'Waktu Masuk: ${dateFormatFull.format(_attendanceController.schedule!.startTime)}\nWaktu Pulang: ${dateFormatFull.format(_attendanceController.schedule!.endTime)}',
                  style: const TextStyle(color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8),
              PresensiTime(
                inTime: _attendanceController.getTodayAttendance()?.clockIn,
                outTime: _attendanceController.getTodayAttendance()?.clockOut,
              ),
              const Spacer(flex: 1),
            ],
          ),
        );
      }),
    );
  }

  _listenLocationChanges() async {
    try {
      final isPermissionGranted =
          await _locationController.requestLocationPermission();
      if (isPermissionGranted) {
        await _locationController.getCurrentLocation();
        _listenGpsStatus();
        _listenPositionChanges();
      }
    } catch (e) {
      _locationController.getCurrentLocation();
      Fluttertoast.showToast(msg: 'Harap izinkan akses GPS untuk melanjutkan');
      // final isPermissionGranted =
      //     await _locationController.requestLocationPermission();
      // if (isPermissionGranted) {
      //   _listenLocationChanges();
      // }
    }
  }

  _listenGpsStatus() {
    _gpsStatusSubscription =
        Geolocator.getServiceStatusStream().listen((gpsStatus) {
      _locationController.gpsStatus = gpsStatus == ServiceStatus.enabled;
    });
  }

  _listenPositionChanges() {
    _gpsPositionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 2,
    )).listen((position) {
      log('LOCATION CHANGED: ${position.toString()}', name: 'PRESENSI PAGE');
      _locationController.currentLocation.value =
          LatLng(position.latitude, position.longitude);

      if (_profileController.user == null) return;

      final workUnit = _attendanceController.schedule;
      final centerPoint = LatLng(workUnit!.lat, workUnit.lng);
      _locationController.checkAttendanceRange(centerPoint, workUnit.radius);
    });
  }

  _onTimeChanged(DateTime now) {
    final todayAttendance = _attendanceController.getTodayAttendance();
    log('TODAY ATTENDANCE START: ${todayAttendance?.clockIn.toString()}');
    log('TODAY ATTENDANCE END: ${todayAttendance?.clockOut.toString()}');

    isAllowAttendance = false;

    // ? decide is presensi masuk or not
    if (todayAttendance?.clockIn == null) {
      isPresensiMasuk = true;
    } else {
      isPresensiMasuk = false;
    }

    // final outTime = _attendanceController.workTime!.endDateTime;
    // if (todayAttendance?.loginTime == null && now.isAfter(outTime)) {
    //   isPresensiMasuk = false;
    // }

    // ? jika sudah absen masuk dan pulang
    if (todayAttendance?.clockIn != null && todayAttendance?.clockOut != null) {
      isAllowAttendance = false;
    }

    // ? jika presensi masuk
    if (isPresensiMasuk) {
      // ? jika diluar waktu absen masuk maka tidak boleh absen
      final attendanceTime = _attendanceController.schedule!.startTime;
      final startAttendanceTime =
          attendanceTime.subtract(const Duration(minutes: 15));
      final endAttendanceTime = attendanceTime.add(const Duration(minutes: 30));

      log('START LIMIT: ${startAttendanceTime.toString()}', name: 'START');
      log('END LIMIT: ${endAttendanceTime.toString()}', name: 'END');

      // ? secara default true
      isAllowAttendance = true;

      // ? jika sebelum batas waktu absensi
      if (now.isBefore(startAttendanceTime)) {
        isAllowAttendance = false;
      }

      // ? jika sesudah batas waktu absensi
      if (now.isAfter(endAttendanceTime)) {
        isAllowAttendance = false;
      }
    } else {
      // ? jika diluar waktu absen pulang maka tidak boleh absen
      final attendanceTime = _attendanceController.schedule!.endTime;
      final startAttendanceTime =
          attendanceTime.subtract(const Duration(minutes: 15));

      log('START PULANG LIMIT: ${startAttendanceTime.toString()}',
          name: 'START');

      // ? secara default true
      isAllowAttendance = true;

      // ? jika sebelum batas waktu absensi pulang
      if (now.isBefore(startAttendanceTime)) {
        isAllowAttendance = false;
      }
    }

    // ? jika diluar area
    if (_locationController.isAllowAttendance == false) {
      isAllowAttendance = false;
    }

    // ? jika sudah absen masuk / pulang
    if (todayAttendance?.clockIn != null && todayAttendance?.clockOut != null) {
      isAllowAttendance = false;
    }

    log('IS MASUK: $isPresensiMasuk', name: 'IS MASUK');
    log('IS ALLOW ATTENDANCE: $isAllowAttendance', name: 'IS ALLOW');

    setState(() {});
  }

  _onRefresh() async {
    await _attendanceController.getSchedule();
    await _attendanceController.getAttendances();
  }

  void _submitPresensi() async {
    if (!isAllowAttendance) return;
    await _attendanceController.submitAttendance(isIn: isPresensiMasuk);
  }
}
