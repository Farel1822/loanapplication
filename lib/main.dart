import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Loan Calculator',
      home: LoanCalculator(),
    ));

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  double monthlyPayment = 0.0;

  void calculateLoan() {
    double principal = double.parse(loanAmountController.text);
    int term = int.parse(termController.text);
    double interest = double.parse(interestController.text) / 100 / 12;
    int totalPayments = term * 12;

    double numerator = interest * pow(1 + interest, totalPayments.toDouble());
    double denominator = pow(1 + interest, totalPayments.toDouble()) - 1;
    double result = principal * (numerator / denominator);

    setState(() {
      monthlyPayment = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: termController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fixed Term (in years)'),
            ),
            TextField(
              controller: interestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateLoan();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
