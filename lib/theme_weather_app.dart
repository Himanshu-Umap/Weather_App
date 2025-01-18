import 'package:flutter/material.dart';

class ThemeWeatherApp extends StatefulWidget {
  @override
  _ThemeWeatherAppState createState() => _ThemeWeatherAppState();
}

class _ThemeWeatherAppState extends State<ThemeWeatherApp> {
  ThemeData _currentTheme = ThemeData.light();

  void _toggleTheme() {
    setState(() {
      _currentTheme =
          _currentTheme == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Theme Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Change the theme:',
              ),
              RaisedButton(
                onPressed: _toggleTheme,
                child: Text(
                  'Toggle Theme',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}