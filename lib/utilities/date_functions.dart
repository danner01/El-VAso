import 'dart:developer';

import 'package:intl/intl.dart';

String dateTimeToString(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd/MM/yy');
  return formatter.format(dateTime);
}

DateTime stringToDateTime(String dateString) {
  log('Date:$dateString');

  final DateFormat formatter = DateFormat('dd/MM/yy');
  if (dateString == "") {
    return stringToDateTime(dateTimeToString(DateTime.now()));
  } else {
    return formatter.parse(dateString);
  }
}

Map<String, String> formatDateTimeAMPM(DateTime date) {
  // Formato de fecha: Viernes 16 de Agosto
  final DateFormat dayFormatter =
      DateFormat('EEEE', 'es_ES'); // Día de la semana
  final DateFormat dayOfMonthFormatter =
      DateFormat('d', 'es_ES'); // Día del mes
  final DateFormat monthFormatter = DateFormat('MMMM', 'es_ES'); // Mes

  String formattedDate =
      '${dayFormatter.format(date)} ${dayOfMonthFormatter.format(date)} de ${monthFormatter.format(date)}';

  // Formato de hora: 10:23 AM
  final DateFormat timeFormatter = DateFormat('h:mm a');
  String formattedTime = timeFormatter.format(date);

  return {
    'formattedDate': formattedDate,
    'formattedTime': formattedTime,
  };
}

Map<String, String> formatDateTime24h(DateTime date) {
  // Formato de fecha: Viernes 16 de Agosto
  final DateFormat dayFormatter =
      DateFormat('EEEE', 'es_ES'); // Día de la semana
  final DateFormat dayOfMonthFormatter =
      DateFormat('d', 'es_ES'); // Día del mes
  final DateFormat monthFormatter = DateFormat('MMMM', 'es_ES'); // Mes

  String formattedDate =
      '${dayFormatter.format(date)} ${dayOfMonthFormatter.format(date)} de ${monthFormatter.format(date)}';

  // Formato de hora: 10:23 en formato de 24 horas
  final DateFormat timeFormatter = DateFormat('HH:mm');
  String formattedTime = timeFormatter.format(date);

  return {
    'formattedDate': formattedDate,
    'formattedTime': formattedTime,
  };
}
