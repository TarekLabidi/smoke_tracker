import '../palette.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BrandCard extends StatefulWidget {
  final Map brand;
  final int smoked;
  final double money;
  final List usedbrands1;
  final ValueChanged<int> totalsmoked;
  final ValueChanged<double> totalmoney;
  final ValueChanged<List<dynamic>> usedbrands;

  const BrandCard(
      {super.key,
      required this.brand,
      required this.totalsmoked,
      required this.smoked,
      required this.totalmoney,
      required this.money,
      required this.usedbrands1,
      required this.usedbrands});

  @override
  State<BrandCard> createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  final _myBox = Hive.box('smokedbox');
  late int number;

  @override
  void initState() {
    super.initState();
    number = _myBox.get('smoked ${widget.brand['name']}') ?? 0;
  }

  void add() {
    setState(() {
      number++;
      _myBox.put('smoked ${widget.brand['name']}', number);
      int ok = widget.smoked + 1;
      widget.totalsmoked(ok);
      double mon = widget.money + double.parse(widget.brand["price"]!);
      widget.totalmoney(mon);
    });
  }

  void minus() {
    if (number > 0) {
      setState(
        () {
          number--;
          _myBox.put('smoked ${widget.brand['name']}', number);
          int ok = widget.smoked - 1;
          widget.totalsmoked(ok);
          double mon = widget.money - double.parse(widget.brand["price"]!);
          widget.totalmoney(mon);
        },
      );
    }
  }

  void details() {}

  void delete() {
    setState(() {
      List newusedbrands = widget.usedbrands1;
      widget.brand['isPresent'] = 'false';
      newusedbrands.remove(widget.brand);
      widget.usedbrands(newusedbrands);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 7,
        color: Palette.tink,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      widget.brand["asset"].toString(),
                      width: 50,
                      height: 56,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.brand['name'].toString(),
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Total : $number",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: delete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        )),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('Plus one cigarrete smoked'),
                    IconButton(
                      onPressed: add,
                      icon: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: minus,
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.green,
                        )),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
