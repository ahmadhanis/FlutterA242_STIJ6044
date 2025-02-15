import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mytukang/newtukangscreen.dart';
import 'package:http/http.dart' as http;
import 'package:mytukang/tukang.dart';

class TukangScreen extends StatefulWidget {
  const TukangScreen({super.key});

  @override
  State<TukangScreen> createState() => _TukangScreenState();
}

class _TukangScreenState extends State<TukangScreen> {
  List<Tukang> tukangList = <Tukang>[]; //list array objects
  String status = "Loading...";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTukang();
  }

  void loadTukang() {
    http
        .get(Uri.parse('http://10.30.1.49/mytukang/api/load_tukang.php'))
        .then((response) {
      //log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        tukangList.clear();
        data['data'].forEach((tukang) {
          Tukang t = Tukang.fromJson(tukang);
          tukangList.add(t);
        });
      } else {
        tukangList.clear();
        status = "No tukang found";
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTukang'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              loadTukang();
            },
          ),
        ],
      ),
      body: tukangList.isEmpty
          ? Center(child: Text(status))
          : ListView.builder(
              itemCount: tukangList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network("http://10.30.1.49/mytukang/assets/${tukangList[index].tukangId}.png"),
                    title: Text(tukangList[index].tukangName.toString()),
                    subtitle: Text(
                        '${tukangList[index].tukangField}\n${tukangList[index].tukangPhone}'),
                    trailing: IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.arrow_circle_right),
                    ),
                  ),
                );
              },
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
