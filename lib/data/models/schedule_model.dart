import 'dart:convert';

ScheduleResponse scheduleModelFromJson(String str) =>
    ScheduleResponse.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleResponse data) => json.encode(data.toJson());

class ScheduleResponse {
  ScheduleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  ScheduleModel data;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      ScheduleResponse(
        success: json["success"],
        message: json["message"],
        data: ScheduleModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.radius,
    required this.office,
    required this.clockIn,
    required this.clockOut,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  double lat;
  double lng;
  double radius;
  String office;
  String clockIn;
  String clockOut;
  DateTime createdAt;
  DateTime updatedAt;

  DateTime get startTime {
    final now = DateTime.now();

    final split = clockIn.split(':');
    final hour = split[0];
    final minute = split[1];

    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(hour),
      int.parse(minute),
    );
  }

  DateTime get endTime {
    final now = DateTime.now();

    final split = clockOut.split(':');
    final hour = split[0];
    final minute = split[1];

    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(hour),
      int.parse(minute),
    );
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        lat: double.parse(json["lat"].toString()),
        lng: double.parse(json["lng"].toString()),
        radius: double.parse(json["radius"].toString()),
        office: json["office"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "radius": radius,
        "office": office,
        "clock_in": clockIn,
        "clock_out": clockOut,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
