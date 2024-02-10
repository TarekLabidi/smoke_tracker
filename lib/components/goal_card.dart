import '../palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class GoalCard extends StatefulWidget {
  ValueChanged<int> goalss;
  ValueChanged<String> date;
  GoalCard({super.key, required this.goalss, required this.date});

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  bool isDateInPast(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now);
  }

  int diff(DateTime date1, DateTime date2) {
    Duration difference = date2.difference(date1);

    int daysDifference = difference.inDays;
    return daysDifference + 1;
  }

  String numbererror = 'Set the Goal Number of cigarettes ';
  String hint = "Enter a number";
  String dateerror = "";
  final _myBox = Hive.box('smokedbox');
  late int goal = 100;
  String day = "";
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            color: Palette.tink,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const Text(
                    'Set Your Goal ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  numbererror,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 41, 93, 135)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: hint,
                    contentPadding: const EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) =>
                      goal = (value.isNotEmpty) ? int.parse(value) : 100,
                ),
              ),
              Text(
                'Choose the date of this Goal',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Card(
                    margin: const EdgeInsets.only(bottom: 10)
                        .copyWith(left: 10, right: 10, top: 10),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          calendarFormat: _calendarFormat,
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                        ),
                      ),
                    )),
              ),
              Text(
                (_focusedDay != null)
                    ? DateFormat('d MMM, y').format(_focusedDay!).toString()
                    : '',
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              Text(
                dateerror,
                style: const TextStyle(
                    color: Color.fromARGB(255, 138, 25, 17),
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Card(
                elevation: 6,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    if (goal == 100) {
                      setState(() {
                        numbererror = 'You didn\'t Enter a Number';
                      });
                    } else if (_focusedDay == null) {
                      setState(() {
                        dateerror = 'Choose a Date Please';
                      });
                    } else if (goal > int.parse(_myBox.get('averge'))) {
                      setState(() {
                        numbererror =
                            'Your averge smoking is already below this number';
                      });
                    } else if (isDateInPast(_focusedDay!)) {
                      setState(() {
                        dateerror = 'You have selected a day from the past';
                      });
                    } else {
                      widget.goalss(goal);
                      _myBox.put(
                          'datediff', diff(DateTime.now(), _focusedDay!));
                      widget.date(DateFormat('d MMM, y')
                          .format(_focusedDay!)
                          .toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You have setted your Goal, Great!!!'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Done", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
