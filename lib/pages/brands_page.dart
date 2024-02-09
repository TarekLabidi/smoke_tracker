import '../components/brand_details.dart';
import '../components/brand_view.dart';
import '../dummydata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
  const Color.fromARGB(255, 103, 237, 137),
];

class BrandsPage extends StatefulWidget {
  const BrandsPage({super.key});

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Chip(
              elevation: 6,
              label: Text(
                "Available Brands :",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: buildBrand(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrand() => SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          children: List.generate(
            allbrands.length,
            (index) {
              final brand = allbrands[index];
              final color = lightColors[index % lightColors.length];
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return BrandDetails(
                          brand: brand,
                          color: color,
                        );
                      }),
                  child: BrandView(
                    brand: brand,
                    index: index,
                    color: color,
                  ),
                ),
              );
            },
          ),
        ),
      );
}
