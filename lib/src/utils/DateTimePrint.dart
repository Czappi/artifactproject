import 'package:get/get.dart';

import 'package:intl/intl.dart';

class DateTimePrint {
  static String parse(DateTime dateTime) {
    var elapsed =
        DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;

    String result = "";

    String getResult(String string) {
      return ["#datetime-prefix-ago".tr, string, "#datetime-suffix-ago".tr]
          .join(" ");
    }

    if (seconds < 60) {
      result = getResult("#datetime-second-ago".tr);
    } else if (seconds < 120) {
      result = getResult(
          seconds.round().toString() + " " + "#datetime-seconds-ago".tr);
    } else if (minutes < 60) {
      result = getResult("#datetime-minute-ago".tr);
    } else if (minutes < 120) {
      result = getResult(
          minutes.round().toString() + " " + "#datetime-minutes-ago".tr);
    } else if (hours < 24) {
      result =
          getResult(hours.round().toString() + " " + "#datetime-hours-ago".tr);
    } else if (hours < 48) {
      result = getResult("#datetime-day-ago".tr);
    } else if (days < 7) {
      result =
          getResult(days.round().toString() + " " + "#datetime-days-ago".tr);
    } else {
      result = DateFormat.yMMMMd(Get.locale?.toLanguageTag() ?? "en_US")
          .format(dateTime);
    }

    return result;
  }
}
