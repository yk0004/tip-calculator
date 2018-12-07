import 'package:flutter/material.dart';
import 'package:tip_calculator/src/pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TipCalculator(title: 'Tip Calculator'),
    );
  }
}
