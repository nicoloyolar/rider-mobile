import 'package:flutter/material.dart';
//import 'package:rider/farmacia_screen.dart';
import 'package:rider/taller_screen.dart';
//import 'package:rider/adulto_mayor_screen.dart';
//import 'package:rider/main_screen.dart';
//import 'package:rider/register_driver_screen.dart';
//import 'package:rider/mascotas_screen.dart';
//import 'package:rider/no_conduzca_screen.dart';
//import 'package:rider/traslado_ciudad_screen.dart';
//import 'package:rider/revision_tecnica_screen.dart';
//import 'package:rider/farmacia_screen.dart';
//import 'package:rider/taller_screen.dart';
//import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TallerScreen(),
    );
  }
}
