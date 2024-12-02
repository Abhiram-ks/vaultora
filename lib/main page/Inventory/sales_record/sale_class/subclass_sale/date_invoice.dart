import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePickerPopup extends StatefulWidget {
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime, DateTime) onDateRangeSelected;

  const DateRangePickerPopup({
    super.key,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.onDateRangeSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DateRangePickerPopupState createState() => _DateRangePickerPopupState();
}

class _DateRangePickerPopupState extends State<DateRangePickerPopup> {
  late DateTime _focusedDay;
  late DateTime? _selectedStartDay;
  late DateTime? _selectedEndDay;
  bool _isStartDateSelection = true;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedStartDay = widget.selectedStartDate ?? DateTime.now(); // Default to today
    _selectedEndDay = widget.selectedEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime.now(),
              focusedDay: _focusedDay,
              enabledDayPredicate: (day) {
                return !day.isAfter(DateTime.now());
              },
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
                    _isStartDateSelection = false; 
                  } else {
                    _selectedEndDay = selectedDay;
                  }
                  _focusedDay = focusedDay;
                });
                if (_selectedStartDay != null && _selectedEndDay != null) {
                  widget.onDateRangeSelected(_selectedStartDay!, _selectedEndDay!);
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedStartDay = DateTime.now();
                      _selectedEndDay = null;
                      _isStartDateSelection = true;
                    });
                  },
                  child: const Text("Reset Date", style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
