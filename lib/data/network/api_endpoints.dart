class ApiEndpoints {
  static const baseUrl = '192.168.0.2';
  static const prefix = '/api';
  static const apiVersion = '';

  // * AUTH
  static const login = '$prefix/auth';
  static const profile = '$prefix$apiVersion/user';
  static const updateAvatar = '$prefix$apiVersion/avatar';
  static const updatePassword = '$prefix$apiVersion/password';

  // * INFO
  static const termsCondition = '/termsandcondition';
  static const privacyPolicy = '/privacypolicy';

  // * ATTENDANCE
  static const schedule = '$prefix$apiVersion/scheduleinfo';
  static const attendance = '$prefix$apiVersion/attendance';
  static String attendanceDetail(int id) => '$attendance/$id';
}
