import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_1_screen.dart';
import 'package:navigation/screen/route_2_screen.dart';
import 'package:navigation/screen/route_3_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/one': (context) => RouteOneScreen(),
        '/two': (context) => RouteTwoScreen(),
        '/three': (context) => RouteThreeScreen(),
      },
    ),
  );
}
