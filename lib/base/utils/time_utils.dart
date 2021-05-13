class TimeUtils {
  /// 解析时间戳
  static String parseTimestamp(int timestamp) {
    return parseDateTime(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String parseDateTime(DateTime date) =>
      "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
          "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
}
