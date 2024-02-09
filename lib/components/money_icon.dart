import 'package:flutter/material.dart';

class MoneyIcon extends StatelessWidget {
  final double money;
  const MoneyIcon({super.key, required this.money});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.circle_outlined,
          size: 87,
        ),
        Text(
          "${(money).abs().toStringAsFixed(3)} D",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
