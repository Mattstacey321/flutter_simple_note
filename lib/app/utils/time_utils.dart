import 'package:intl/intl.dart';

class TimeUtils {
  String fullDate(DateTime time) {
    return DateFormat.yMMMMd().format(time);
  }
}