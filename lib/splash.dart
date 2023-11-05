import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(MaterialApp(
      title: 'Loan Calculator',
      home: const SplashScreen(),
      routes: {
        '/calculator': (context) => const LoanCalculator(),
      },
    ));

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/calculator');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'src/calculator.png', // gambar 
          height: 200, 
          width: 200, 
        ),
      ),
    );
  }
}
