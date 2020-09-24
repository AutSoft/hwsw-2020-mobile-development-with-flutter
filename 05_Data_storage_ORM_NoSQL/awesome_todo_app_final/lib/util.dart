import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  return DateFormat("yyyy.MM.dd").format(date);
}