import 'dart:convert';

AttendanceResponse attendanceModelFromJson(String str) =>
    AttendanceResponse.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceResponse data) =>
    json.encode(data.toJson());

class AttendanceResponse {
  AttendanceResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<AttendanceModel> data;

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceResponse(
        success: json["success"],
        message: json["message"],
        data: List<AttendanceModel>.from(
            json["data"].map((x) => AttendanceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AttendanceModel {
  AttendanceModel({
    required this.id,
    required this.idUser,
    required this.clockIn,
    required this.clockOut,
    required this.createdAt,
  });

  int id;
  int idUser;
  DateTime? clockIn;
  DateTime? clockOut;
  DateTime createdAt;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["id"],
        idUser: json["id_user"],
        clockIn:
            json["clock_in"] == null ? null : DateTime.parse(json["clock_in"]),
        clockOut: json["clock_out"] == null
            ? null
            : DateTime.parse(json["clock_out"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "clock_in": clockIn?.toIso8601String(),
        "clock_out": clockOut?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}
