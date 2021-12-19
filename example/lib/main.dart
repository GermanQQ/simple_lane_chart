import 'package:flutter/material.dart';
import 'package:simple_lane_chart/simple_lane_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Example lane chart'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({required this.title});
  final int firstValue = 23;
  final int secondValue = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SimpleLaneChart(
            firstValue,
            secondValue,
            height: 20,
          ),
        ),
      ),
    );
  }
}
