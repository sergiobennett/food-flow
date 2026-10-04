import 'package:flutter/material.dart';
import 'pages/login_page.dart';


void main() {
  runApp(const FoodFlowApp());
}


class FoodFlowApp extends StatelessWidget {

  const FoodFlowApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'FoodFlow',

      theme: ThemeData(

        primarySwatch: Colors.orange,

      ),

      home: const LoginPage(),

    );

  }
}