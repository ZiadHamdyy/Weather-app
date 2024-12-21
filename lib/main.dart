import 'package:flutter/material.dart';
import 'package:new_flutter/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData.light(useMaterial3: true),
      home: const WeatherPage(),
    );
  }
}

