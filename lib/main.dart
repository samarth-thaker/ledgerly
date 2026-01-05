import 'package:flutter/material.dart';
import 'package:ledgerly/features/main/screen/main_screen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  static get observer => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

