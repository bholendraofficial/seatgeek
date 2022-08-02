/*
 * Copyright (c) Bholendra Singh 2022.
 */

import 'package:intl/intl.dart';

class Utils {
  static String parseDateTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat().format(dateTime);
    return formattedDate;
  }
}
