String calculateTotalTime(DateTime inTime, DateTime outTime,
    {bool isDetailed = false}) {
  final diff = outTime.difference(inTime);
  final hour = diff.inHours;
  final minute = diff.inMinutes % 60;
  final hourString = hour < 10 ? '0$hour' : hour.toString();
  final minuteString = minute < 10 ? '0$minute' : minute.toString();

  if (isDetailed) return '$hourString jam $minuteString menit';
  return '${hourString}j ${minuteString}m';
}
