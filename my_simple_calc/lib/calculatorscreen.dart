import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController firstNumber = TextEditingController();
  TextEditingController secondNumber = TextEditingController();
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MyCalculator"),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              controller: firstNumber,
            ),
            TextField(
              controller: secondNumber,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addOperation();
                    },
                    child: const Text("+")),
                ElevatedButton(
                    onPressed: () {
                      minusOperation();
                    },
                    child: const Text("-")),
                ElevatedButton(
                    onPressed: () {
                      multOperation();
                    },
                    child: const Text("x")),
                ElevatedButton(
                    onPressed: () {
                      divOperation();
                    },
                    child: const Text("/")),
              ],
            ),
            Text("Result: $result")
          ]),
        ));
  }

  void addOperation() {
    double numa = double.parse(firstNumber.text);
    double numb = double.parse(secondNumber.text);
    result = numa + numb;
    setState(() {});
  }

  void minusOperation() {
    double numa = double.parse(firstNumber.text);
    double numb = double.parse(secondNumber.text);
    result = numa - numb;
    setState(() {});
  }

  void multOperation() {
    double numa = double.parse(firstNumber.text);
    double numb = double.parse(secondNumber.text);
    result = numa * numb;
    setState(() {});
  }

  void divOperation() {
    double numa = double.parse(firstNumber.text);
    double numb = double.parse(secondNumber.text);
    result = numa / numb;
    setState(() {});
  }
}
