import 'package:intl/intl.dart';

class DateUtils {
  static DateTime parseDate(String date) {
    DateFormat format = DateFormat("MMM dd, yyyy hh:mm:ss a");
    date = date.replaceFirst(' pm', ' PM').replaceFirst(' am', ' AM');
    return format.parse(date);
  }
}
