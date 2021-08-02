import 'package:intl/intl.dart';

class FormatUtils {
  static DateTime formatDate(String date) {
    try {
      return DateFormat("MMM dd,yyyy hh:mm").parse(date);
    } catch (e) {
      return DateTime(1970);
    }
  }

  static DateTime formatMLDate(String date) {
    try {
      return DateFormat("MMM dd,yy").parse(date);
    } catch (e) {
      return DateTime(1970);
    }
  }

  static int formatView(String view) =>
      int.tryParse(view.replaceAll(",", "")) ?? 0;

  static String formatDesc(String desc) {
    var _desc = desc;

    // break line
    _desc = _desc.replaceAll("<br>", "\n");

    return _desc;
  }
}
