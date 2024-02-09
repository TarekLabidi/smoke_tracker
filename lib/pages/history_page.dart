import '../components/goal_card.dart';
import '../palette.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int index = 4;
  String calcul() {
    num tot = 0;
    for (int i = 0; i < history.length; i++) {
      tot = tot + history[i]['smoked'];
    }
    double averge = tot / (history.length);
    _myBox.put('averge', averge.toStringAsFixed(0));
    return tot.toString();
  }

  String calcul2() {
    double tot = 0;
    for (int i = 0; i < history.length; i++) {
      tot = tot + history[i]['money'];
    }
    return tot.abs().toStringAsFixed(3).toString();
  }

  final _myBox = Hive.box('smokedbox');
  late List history;

  @override
  void initState() {
    history = _myBox.get('historylist') ?? [];
    super.initState();
  }

  List<SmokedData> data(int index) {
    List<SmokedData> smokedDataList = [];

    if (index == 1) {
      for (int i = 0; i < history.length && i < 29; i++) {
        smokedDataList.insert(
            0,
            SmokedData(
              history[i]['date'],
              history[i]['smoked'],
            ));
      }
    } else if (index == 2) {
      for (int i = 0; i < history.length && i < 29; i++) {
        smokedDataList.insert(
            0,
            SmokedData(
              history[i]['date'],
              history[i]['smoked'],
            ));
      }
    } else if (index == 3) {
      for (int i = 0; i < history.length && i < 29; i++) {
        smokedDataList.insert(
            0,
            SmokedData(
              history[i]['date'],
              history[i]['smoked'],
            ));
      }
    } else {
      for (int i = 0; i < history.length && i < 29; i++) {
        smokedDataList.insert(
            0,
            SmokedData(
              history[i]['date'],
              history[i]['smoked'],
            ));
      }
    }

    return smokedDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: (history.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          shadowColor: Palette.tink,
                          elevation: 6,
                          color: (index == 1) ? Palette.tink : Colors.white,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: const Text("1 week"),
                          ),
                        ),
                        Card(
                          shadowColor: Palette.tink,
                          elevation: 6,
                          color: (index == 2) ? Palette.tink : Colors.white,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                index = 2;
                              });
                            },
                            child: const Text("1 Month"),
                          ),
                        ),
                        Card(
                          shadowColor: Palette.tink,
                          elevation: 6,
                          color: (index == 3) ? Palette.tink : Colors.white,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                index = 3;
                              });
                            },
                            child: const Text("1 Year"),
                          ),
                        ),
                        Card(
                          shadowColor: Palette.tink,
                          elevation: 6,
                          color: (index == 4) ? Palette.tink : Colors.white,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                index = 4;
                              });
                            },
                            child: const Text("All"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Card(
                      shadowColor: Palette.tink,
                      elevation: 6,
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: SfCartesianChart(
                          title:
                              const ChartTitle(text: 'Your Smoking Statistics'),
                          primaryXAxis: const CategoryAxis(),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <SplineSeries<SmokedData, String>>[
                            SplineSeries<SmokedData, String>(
                              dataSource: data(index = index),
                              xValueMapper: (SmokedData sales, _) => sales.day,
                              yValueMapper: (SmokedData sales, _) =>
                                  sales.sales,
                              name: 'Smoked',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      shadowColor: Palette.tink,
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Total Cigarettes Smoked: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: calcul(),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            20 // Optional: You can customize the style
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Total Money Spent: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: calcul2(),
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Your averge cigarettes per day is  ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                children: [
                                  TextSpan(
                                    text: _myBox.get('averge'),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 226, 127, 127),
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Card(
                                elevation: 6,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return GoalCard(
                                            goalss: (value) => setState(() {
                                              _myBox.put('goalnumber', value);
                                            }),
                                            date: (value) => setState(() {
                                              _myBox.put('goaldate', value);
                                            }),
                                          );
                                        });
                                  },
                                  child: const Text(
                                    'Set Your Goal',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            (_myBox.get('goaldate') != null &&
                                    _myBox.get('goaldate') !=
                                        _myBox.get('yesterday'))
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Your current Goal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Palette.titleColor),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text: 'Your Goal is Date : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          children: [
                                            TextSpan(
                                              text: _myBox.get('goaldate'),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 158, 171, 35),
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text: 'Your Goal ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_myBox.get('goalnumber').toString()} Cigarettes',
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 158, 171, 35),
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Card(
                                          shadowColor: Palette.tink,
                                          elevation: 4,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _myBox.delete('goaldate');
                                                _myBox.delete('goalnumber');
                                              });
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                  vertical: 5),
                                              child: Text(
                                                'Remove this Goal',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Chip(
                      elevation: 6,
                      side: BorderSide(color: Colors.amber[200]!),
                      shadowColor: Palette.tink,
                      label: Text('Days History ',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final day = history[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Card(
                            surfaceTintColor: Colors.amber[100],
                            shadowColor: Palette.tink,
                            elevation: 6,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Palette.tink,
                                  borderRadius: BorderRadius.circular(12)),
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListTile(
                                  title: Text(
                                    'Day : ${day['date']}',
                                  ),
                                  subtitle: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: 'Smoked : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                          text: '${day['smoked']}',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: '\nMoney Spent : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight
                                                  .bold // Set the text color to black
                                              ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${day['money'].abs().toStringAsFixed(3)}',
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  SfCartesianChart(
                    title: const ChartTitle(text: 'Your Smoking Statistics'),
                    primaryXAxis: const CategoryAxis(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <SplineSeries<SmokedData, String>>[
                      SplineSeries<SmokedData, String>(
                        dataSource: [
                          SmokedData(
                              DateFormat('d MMM, y')
                                  .format(DateTime.now())
                                  .toString(),
                              0)
                        ],
                        xValueMapper: (SmokedData sales, _) => sales.day,
                        yValueMapper: (SmokedData sales, _) => sales.sales,
                        name: 'Smoked',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Card(
                      surfaceTintColor: Colors.amber[300],
                      shadowColor: Palette.tink,
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'It Is Still Your first Day',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                'You Still Have No History',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
      ),
    );
  }
}

class SmokedData {
  SmokedData(this.day, this.sales);
  final int sales;
  final String day;
}
