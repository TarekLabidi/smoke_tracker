import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BrandDetails extends StatefulWidget {
  final Map<String, String> brand;
  final Color color;
  const BrandDetails({super.key, required this.brand, required this.color});

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  final _myBox = Hive.box('smokedbox');

  late List<dynamic> usedbrands;
  @override
  void initState() {
    usedbrands = _myBox.get('usedbrands') ?? [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 9, horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      widget.brand['asset']!,
                      height: 180,
                      width: 180,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Name Of The Brand : ${widget.brand['name']}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 77, 76, 76),
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Price of one Cigarette : ${widget.brand['price']} Dinar',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 77, 76, 76),
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Price of one Pack : ${widget.brand['packprice']} Dinar',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 77, 76, 76),
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (widget.brand['isPresent'] == 'true')
                            ? 'Added To Used Brands'
                            : 'Add To Used Brands',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: const Color.fromARGB(255, 77, 76, 76),
                                ),
                      ),
                      const SizedBox(
                        width: 10,
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
                        icon: const Icon(
                          Icons.add_box,
                          color: Colors.red,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
