import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plj_absensi_mobile/modules/presensi/widgets/location_dialog.dart';

class LocationController extends GetxController {
  Rx<LatLng> currentLocation =
      const LatLng(-8.1691328, 113.7022499).obs; // default alun"

  RxBool isGpsEnabled = false.obs;
  RxBool isInArea = false.obs;
  Rx<LocationPermission> locationPermission = LocationPermission.denied.obs;

  bool get isAllowAttendance {
    if (locationPermission.value == LocationPermission.denied) return false;
    if (locationPermission.value == LocationPermission.deniedForever) {
      return false;
    }
    if (!isGpsEnabled.value) return false;
    if (!isInArea.value) return false;

    return true;
  }

  set gpsStatus(bool isEnabled) {
    log('IS GPS ENABLED: $isEnabled', name: 'LOCATION CONTROLLER');
    isGpsEnabled.value = isEnabled;
  }

  Future<bool> requestLocationPermission() async {
    // Test if location services are enabled.

    isGpsEnabled.value = await Geolocator.isLocationServiceEnabled();
    if (!isGpsEnabled.value) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    locationPermission.value = await Geolocator.checkPermission();
    if (locationPermission.value == LocationPermission.denied) {
      locationPermission.value = await Geolocator.requestPermission();
      if (locationPermission.value == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (locationPermission.value == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return true;
  }

  Future<bool> getCurrentLocation() async {
    try {
      final currPosition = await Geolocator.getCurrentPosition();
      currentLocation.value =
          LatLng(currPosition.latitude, currPosition.longitude);
      return true;
    } catch (e) {
      currentLocation.value = const LatLng(-8.1691328, 113.7022499);
      Fluttertoast.showToast(
          msg:
              'Anda harus mengaktifkan GPS untuk memperoleh lokasi yang akurat');
      Get.dialog(const LocationDialog());
      return false;
    }
  }

  Future<void> checkAttendanceRange(LatLng centerPoint, double range) async {
    final distance = Geolocator.distanceBetween(
      currentLocation.value.latitude,
      currentLocation.value.longitude,
      centerPoint.latitude,
      centerPoint.longitude,
    );

    if (distance > range) {
      log('OUT OF AREA', name: 'LOCATION CONTROLLER');
      isInArea.value = false;
      return;
    }

    log('IS IN AREA', name: 'LOCATION CONTROLLER');
    isInArea.value = true;
  }
}
