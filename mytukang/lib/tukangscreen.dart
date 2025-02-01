import 'package:flutter/material.dart';

class TukangScreen extends StatefulWidget {
  const TukangScreen({super.key});

  @override
  State<TukangScreen> createState() => _TukangScreenState();
}

class _TukangScreenState extends State<TukangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  const Center(
        child: Text(
          'MyTukang',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
