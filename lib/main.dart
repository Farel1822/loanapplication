// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'splash.dart';

void main() => runApp(MaterialApp(
      title: 'Loan Calculator',
      home:
          const SplashScreen(), // Menggunakan splash screen sebagai halaman awal
      routes: {
        '/calculator': (context) => const LoanCalculator(),
      },
    ));

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  double monthlyPayment = 0.0;
  double yearPayment = 0.0;
  double totalInterest = 0.0;

  void calculateLoan() {
    double p0 = double.parse(loanAmountController.text);
    int time = int.parse(timeController.text);
    double interestRate = double.parse(interestController.text) / 100 / 12;
    int totalPayments = time * 12;

    double atas =
        interestRate * pow(1 + interestRate, totalPayments.toDouble());
    double bawah = pow(1 + interestRate, totalPayments.toDouble()) - 1;
    double result = p0 * (atas / bawah);
    double totalPayment = result * totalPayments;
    double interest = totalPayment - p0;

    setState(() {
      monthlyPayment = result;
      yearPayment = totalPayment;
      totalInterest = interest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'src/calculator.png',
              height: 30,
            ),
            TextField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Fixed Term (in years)'),
            ),
            TextField(
              controller: interestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Interest Rate (%)'),
            ),
            const SizedBox(height: 1),
            ElevatedButton(
              onPressed: () {
                calculateLoan();
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 10),
            Text(
              'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Year Payment: \$${yearPayment.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Total Interest: \$${totalInterest.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
