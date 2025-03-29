import 'package:intl/intl.dart';

class DateFormatUtil {
  static String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MMMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return "Unknown Date";
    }
  }
}
