import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../config/theme/my_themes.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  final List<DateTime> _selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: TableCalendar(
        locale: 'es_ES',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        rangeSelectionMode: _rangeSelectionMode, // Activar selección de rangos
        /////////////////////////////////////////////
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          todayTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
          todayDecoration: BoxDecoration(
            color: (Theme.of(context).scaffoldBackgroundColor.value ==
                    whiteColor.value)
                ? const Color.fromARGB(50, 124, 126, 126)
                : whiteColor,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(color: Colors.white),
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
          outsideTextStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          defaultTextStyle: TextStyle(
              fontSize: 15,
              color: (Theme.of(context).scaffoldBackgroundColor.value ==
                      whiteColor.value)
                  ? Colors.black
                  : whiteColor),
          markerDecoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        /////////////////////////////////////////////
        daysOfWeekHeight: 40,
        rowHeight: 40,
        /////////////////////////////////////////////

        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) => _dayTextFormatter(date),
          weekdayStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: (Theme.of(context).scaffoldBackgroundColor.value ==
                    whiteColor.value)
                ? Colors.black
                : whiteColor,
          ),
          weekendStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: (Theme.of(context).scaffoldBackgroundColor.value ==
                    whiteColor.value)
                ? primaryColor
                : whiteColor,
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 124, 126, 126),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            border: Border(
              bottom: BorderSide(color: Colors.white),
            ),
          ),
        ),
        /////////////////////////////////////////////

        headerStyle: HeaderStyle(
          titleTextFormatter: (date, locale) =>
              _customMonthFormat(date), // Personalizar formato del mes
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: (Theme.of(context).scaffoldBackgroundColor.value ==
                      whiteColor.value)
                  ? Colors.black
                  : whiteColor,
              fontSize: 15),
          leftChevronIcon: Icon(Icons.chevron_left,
              size: 40,
              color: (Theme.of(context).scaffoldBackgroundColor.value ==
                      whiteColor.value)
                  ? primaryColor
                  : whiteColor),
          rightChevronIcon: Icon(Icons.chevron_right,
              size: 40,
              color: (Theme.of(context).scaffoldBackgroundColor.value ==
                      whiteColor.value)
                  ? primaryColor
                  : whiteColor),
          titleCentered: true,
        ),
        /////////////////////////////////////////////

        selectedDayPredicate: (day) {
          return _selectedDays.contains(day);
        },
        /////////////////////////////////////////////
        onDaySelected: (selectedDay, focusedDay) {
          print('press');
          if (_rangeSelectionMode == RangeSelectionMode.toggledOn) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null; // Reset any previously selected range
              _rangeEnd = null;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          } else {
            setState(() {
              _focusedDay = focusedDay;
              if (_selectedDays.contains(selectedDay)) {
                _selectedDays.remove(selectedDay);
              } else {
                _selectedDays.add(selectedDay);
              }
            });
          }
        },

        /////////////////////////////////////////////
        onRangeSelected: (start, end,selectedDay) {
          print('rangue press');
          setState(() {
             _selectedDay = selectedDay;
            // _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
        /////////////////////////////////////////////

        calendarFormat: CalendarFormat.month,
      ),
    );
  }

  // Método para personalizar los nombres de los días
  String _dayTextFormatter(DateTime date) {
    const days = ["L", "M", "X", "J", "V", "S", "D"];
    return days[
        date.weekday - 1]; // weekday devuelve 1 para lunes y 7 para domingo
  }

  // Método para personalizar el formato del mes
  String _customMonthFormat(DateTime date) {
    const months = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    return "${months[date.month - 1]} ${date.year}";
  }
}
