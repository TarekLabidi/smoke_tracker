import 'package:first_try_for_a_good_app/components/brand_card.dart';
import 'package:first_try_for_a_good_app/components/money_icon.dart';
import 'package:first_try_for_a_good_app/components/somke_icon.dart';
import 'package:first_try_for_a_good_app/dummydata.dart';
import 'package:first_try_for_a_good_app/palette.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatefulWidget {
  final ValueChanged<int> currentIndexCallBack;

  const TodayPage({super.key, required this.currentIndexCallBack, r});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final _myBox = Hive.box('smokedbox');
  late List usedbrands = [];
  late List history;

  String? calculategoal() {
    int goal = _myBox.get('goalnumber');
    int diff = _myBox.get('datediff');
    String tod = (goal + diff).toString();
    return tod;
  }

  void reset() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM, y').format(now).toString();
    DateTime yesterday = now.subtract(const Duration(days: 1));

    _myBox.put(
        'yesterday', DateFormat('d MMM, y').format(yesterday).toString());

    String formattedDate1 = DateFormat('d MMM, y').format(yesterday).toString();

    if (_myBox.get('firstday') == null) {
      _myBox.put('firstday', formattedDate);
    }

    if (history.isNotEmpty) {
      if (history[0]['date'] != formattedDate1) {
        double moneyToday = _myBox.get('moneytoday')?.toDouble() ?? 0.0;
        int smokedToday = _myBox.get('smokedtoday') ?? 0;

        Map todaydata = {
          'smoked': smokedToday,
          'money': moneyToday,
          'date': formattedDate1,
        };
        history.insert(0, todaydata);
        _myBox.put('historylist', history);

        setState(() {
          _myBox.put('smokedtoday', 0);
          _myBox.put('moneytoday', 0.0);

          for (int i = 0; i < allbrands.length; i++) {
            _myBox.put('smoked ${allbrands[i]['name']}', 0);
          }
        });
      } else if (history[0]['date'] == formattedDate1) {}
    } else if (_myBox.get('firstday') != formattedDate) {
      double moneyToday = _myBox.get('moneytoday')?.toDouble() ?? 0.0;
      int smokedToday = _myBox.get('smokedtoday') ?? 0;

      Map todaydata = {
        'smoked': smokedToday,
        'money': moneyToday,
        'date': formattedDate1,
      };

      history.insert(0, todaydata);
      _myBox.put('historylist', history);

      setState(() {
        _myBox.put('smokedtoday', 0);
        _myBox.put('moneytoday', 0.0);

        for (int i = 0; i < allbrands.length; i++) {
          _myBox.put('smoked ${allbrands[i]['name']}', 0);
        }
      });
    }
  }

  @override
  void initState() {
    usedbrands = _myBox.get('usedbrands') ?? [];
    history = _myBox.get('historylist') ?? [];
    reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (_myBox.get('goaldate') != null)
                    ? Center(
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your Goal',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                const Text(
                                  "To achive Your overall goal achive today s gaol",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Dont surpass ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: calculategoal()!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 192, 145, 7),
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' cigarettes',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (_myBox.get('smokedtoday') ==
                                          int.parse(calculategoal()!))
                                      ? 'You Have Reached Your limit Careful Now'
                                      : (_myBox.get('smokedtoday') <
                                              int.parse(calculategoal()!)
                                          ? 'You didnt surpass Your limit Great Keep going'
                                          : 'You have Surpassed your limit Slow Down!!!'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight
                                        .bold, // Adjust the font size as needed
                                    color: (_myBox.get('smokedtoday') ==
                                            int.parse(calculategoal()!))
                                        ? const Color.fromARGB(
                                            255, 203, 132, 26)
                                        : (_myBox.get('smokedtoday') <
                                                int.parse(calculategoal()!)
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 30),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 2),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SomkeIcon(
                              smoked: (_myBox.get('smokedtoday') == null)
                                  ? 0
                                  : _myBox.get('smokedtoday'),
                            ),
                            const SizedBox(width: 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cigarettes Smoked ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "Today",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const Spacer()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MoneyIcon(
                              money: (_myBox.get('moneytoday') == null)
                                  ? 0
                                  : _myBox.get('moneytoday'),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Money Spent Today",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Brands You Use :",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Palette.titleColor),
                  ),
                ),
                const SizedBox(height: 20),
                (usedbrands.isNotEmpty)
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: usedbrands.length,
                        itemBuilder: (context, index) {
                          final brand = usedbrands[index];
                          return BrandCard(
                            brand: brand,
                            totalsmoked: (smoked) => setState(() {
                              _myBox.put('smokedtoday', smoked);
                            }),
                            smoked: (_myBox.get('smokedtoday') == null)
                                ? 0
                                : _myBox.get('smokedtoday'),
                            totalmoney: (money) => setState(() {
                              _myBox.put('moneytoday', money);
                            }),
                            money: (_myBox.get('moneytoday') == null)
                                ? 0
                                : _myBox.get('moneytoday'),
                            usedbrands1: usedbrands,
                            usedbrands: (newusedbrands) => setState(() {
                              _myBox.put('usedbrands', newusedbrands);
                            }),
                          );
                        })
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Text(
                              "Select Your faviorte Brands",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              onPressed: () {
                                widget.currentIndexCallBack(1);
                              },
                              icon: const Icon(
                                Icons.add_box_rounded,
                                size: 50,
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
