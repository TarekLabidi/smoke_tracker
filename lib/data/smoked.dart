import 'package:hive/hive.dart';

part 'smoked.g.dart';

@HiveType(typeId: 1)
class Smoked {
  Smoked({required this.somkedtoday, required this.spenttoday});

  @HiveField(0)
  int somkedtoday;

  @HiveField(1)
  double spenttoday;
}
