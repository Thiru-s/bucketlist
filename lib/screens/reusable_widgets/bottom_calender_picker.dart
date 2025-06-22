import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BottomCalendarPicker extends StatefulWidget {
  final DateTime initialSelectedDate;
  final Function(DateTime selectedDate, String formattedUI, String formattedAPI) onDateSelected;

  const BottomCalendarPicker({
    super.key,
    required this.initialSelectedDate,
    required this.onDateSelected,
  });

  @override
  State<BottomCalendarPicker> createState() => _BottomCalendarPickerState();
}

class _BottomCalendarPickerState extends State<BottomCalendarPicker> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialSelectedDate;
    _focusedDay = widget.initialSelectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              final formattedUI = DateFormat('dd/MM/yy').format(selectedDay);
              final formattedAPI = DateFormat('yyyy-MM-dd').format(selectedDay);
              widget.onDateSelected(selectedDay, formattedUI, formattedAPI);
              Navigator.of(context).pop();
            },
            availableCalendarFormats: const {
              CalendarFormat.month: '',
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black),
              titleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekVisible: false,
            headerVisible: true,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
