import '../palette.dart';
import 'package:flutter/material.dart';

class SomkeIcon extends StatelessWidget {
  final int smoked;
  const SomkeIcon({super.key, required this.smoked});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/bodycig.png",
          height: 100,
          width: 100,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              const SizedBox(
                width: 58,
              ),
              Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.titleColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        smoked.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
