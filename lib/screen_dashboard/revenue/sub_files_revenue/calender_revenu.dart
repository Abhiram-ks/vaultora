import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePicker extends StatefulWidget {
  final Function(DateTime? start, DateTime? end) onDateRangeSelected;

  const DateRangePicker({super.key, required this.onDateRangeSelected});

  @override
  // ignore: library_private_types_in_public_api
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  late DateTime _focusedDay;
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  bool _isStartDateSelection = true;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedStartDay = null;
    _selectedEndDay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime.now(),
                focusedDay: _focusedDay,
                enabledDayPredicate: (day) => !day.isAfter(DateTime.now()),
                selectedDayPredicate: (day) {
                  if (_isStartDateSelection) {
                    return isSameDay(_selectedStartDay, day);
                  } else {
                    return isSameDay(_selectedEndDay, day);
                  }
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (_selectedStartDay != null &&
                        _selectedEndDay != null &&
                        day.isAfter(_selectedStartDay!) &&
                        day.isBefore(_selectedEndDay!)) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (_isStartDateSelection) {
                      _selectedStartDay = selectedDay;
                      _selectedEndDay = null;
                      _isStartDateSelection = false;
                    } else {
                      if (selectedDay.isBefore(_selectedStartDay!)) {
                        _selectedStartDay = selectedDay;
                        _selectedEndDay = null;
                        _isStartDateSelection = false;
                      } else {
                        _selectedEndDay = selectedDay;
                        _isStartDateSelection = true;
                      }
                    }
                    _focusedDay = focusedDay;
                  });

                  widget.onDateRangeSelected(
                    _selectedStartDay!,
                    _selectedEndDay,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStartDay = null;
                        _selectedEndDay = null;
                        _isStartDateSelection = true;
                      });
                      widget.onDateRangeSelected(
                        null,
                        null,
                      );
                    },
                    child: const Text("Reset Date",
                        style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close",
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
