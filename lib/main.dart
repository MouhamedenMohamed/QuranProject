import 'package:flutter/material.dart';
import 'package:forqan/constantes/colors.dart';
import 'package:forqan/screens/home.dart';

void main() {
  runApp(MyApp());                                                                                                                                                                                                                                                                                                                                                                                                                                    
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forqan',
      theme: ThemeData(
        primaryColor: appColor,
      ),
      home: HomeScreen(),
    );
  }
}
