import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String output = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Weather App'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weather Info: $output"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  getWeather();
                },
                child: const Text("Get Weather"))
          ],
        ),
      ),
    );
  }

  Future<void> getWeather() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Searching..', max: 100);
    var response = await http.get(Uri.parse(
        'https://api.data.gov.my/weather/forecast/?contains=Jitra@location__location_name'));
    var data = json.decode(response.body);
    output =
        "\nPagi: ${data[6]['morning_forecast']}\nTengahari: ${data[6]['afternoon_forecast']}\nMalam: ${data[6]['night_forecast']}";
    //log(data[6]['morning_forecast'].toString());
    setState(() {});
    pd.close();
  }
}
