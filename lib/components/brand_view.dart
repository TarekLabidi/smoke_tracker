import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BrandView extends StatefulWidget {
  final Map brand;
  final int index;
  final Color color;
  const BrandView(
      {super.key,
      required this.brand,
      required this.index,
      required this.color});

  @override
  State<BrandView> createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {
  final _myBox = Hive.box('smokedbox');
  late List<dynamic> usedbrands;
  @override
  void initState() {
    usedbrands = _myBox.get('usedbrands') ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(18.0)
                .copyWith(bottom: 2, right: 6, left: 6),
            child: Column(
              children: [
                Image.asset(
                  widget.brand['asset']!,
                  height: 90,
                  width: 90,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.brand['name']!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  (widget.brand['isPresent'] == 'true')
                      ? 'Added To Used Brands'
                      : 'Add To Used Brands',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 69, 66, 66),
                      ),
                ),
                IconButton(
                  onPressed: () {
                    if (widget.brand['isPresent'] == 'false') {
                      setState(() {
                        widget.brand['isPresent'] = 'true';
                      });

                      usedbrands.add(widget.brand);
                      _myBox.put('usedbrands', usedbrands);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "The brand is added to the list.",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "The brand is already in the list.",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add_box),
                  iconSize: 35,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
