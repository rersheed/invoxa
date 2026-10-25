import 'package:intl/intl.dart';

String formatLongDate(DateTime date) => DateFormat('d MMM y').format(date);

String formatIsoDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

DateTime? parseIsoDate(String value) => DateTime.tryParse(value);
