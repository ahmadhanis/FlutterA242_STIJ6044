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
            Image.asset('assets/calc.png', scale: 3),
            const SizedBox(height: 20),
            TextField(
              controller: firstNumber,
              decoration: InputDecoration(
                hintText: "Enter first number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: secondNumber,
              decoration: InputDecoration(
                hintText: "Enter second number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
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
            ),
            Text("Result: $result",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
