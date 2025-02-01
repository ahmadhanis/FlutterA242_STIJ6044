import 'package:flutter/material.dart';
import 'package:mytukang/newtukangscreen.dart';

class TukangScreen extends StatefulWidget {
  const TukangScreen({super.key});

  @override
  State<TukangScreen> createState() => _TukangScreenState();
}

class _TukangScreenState extends State<TukangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTukang'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:  const Center(
        child: Text(
          'MyTukang Screen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const NewTukangScreen()),
         ); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
