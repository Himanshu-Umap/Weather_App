import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({super.key});

  @override
  State<MyWeatherApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyWeatherApp> {

  ThemeData _currentTheme = ThemeData.dark(useMaterial3: true);

  void _toggleTheme(){
    setState((){
      _currentTheme =
        _currentTheme == ThemeData.dark(useMaterial3: true) ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    theme: _currentTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: _currentTheme,
      home: const WeatherScreen(),
    );
  }
}