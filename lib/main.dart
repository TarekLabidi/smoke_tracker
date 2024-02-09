import 'home.dart';
import 'palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SmokedAdapter());
  await Hive.openBox('smokedbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "robo",
        colorScheme: const ColorScheme.light(),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Palette.titleColor),
          titleMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
          titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ),
      home: const HomePage(),
    );
  }
}
