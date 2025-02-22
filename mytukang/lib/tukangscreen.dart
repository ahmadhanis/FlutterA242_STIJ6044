import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mytukang/myconfig.dart';
import 'package:mytukang/newtukangscreen.dart';
import 'package:http/http.dart' as http;
import 'package:mytukang/tukang.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TukangScreen extends StatefulWidget {
  const TukangScreen({super.key});

  @override
  State<TukangScreen> createState() => _TukangScreenState();
}

class _TukangScreenState extends State<TukangScreen> {
  List<Tukang> tukangList = <Tukang>[]; //list array objects
  String status = "Loading...";
  late double screenHeight, screenWidth;
  DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');

  var districts = [
    'All',
    'Baling',
    'Bandar Baharu',
    'Kota Setar',
    'Kuala Muda',
    'Kubang Pasu',
    'Kulim',
    'Langkawi',
    'Padang Terap',
    'Pendang',
    'Pokok Sena',
    'Sik',
    'Yan'
  ];

  var fields = [
    'All',
    'Plumber',
    'Electrician',
    'Gardener',
    'Painter',
    'Cleaner',
    'Cook',
    'Driver',
    'Builder',
    'Carpenter',
    'Mechanic',
    'Caterer',
    'Other'
  ];

  String selectedDistrict = 'All';
  String selectedField = 'All';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTukang();
  }

  void loadTukang() {
    http
        .get(Uri.parse(
            '${MyConfig.baseUrl}/api/load_tukang.php?district=$selectedDistrict&field=$selectedField'))
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTukang'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog();
            },
          ),
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
                    leading: Image.network(
                        "${MyConfig.baseUrl}/assets/${tukangList[index].tukangId}.png"),
                    title: Text(tukangList[index].tukangName.toString()),
                    subtitle: Text(
                        '${tukangList[index].tukangField}\n${tukangList[index].tukangPhone}'),
                    trailing: IconButton(
                      onPressed: () => {showTukangDetails(index)},
                      icon: const Icon(Icons.info),
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

  showTukangDetails(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(tukangList[index].tukangField.toString()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "${MyConfig.baseUrl}/assets/${tukangList[index].tukangId}.png"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tukangList[index].tukangName.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Table(
                  // textDirection: TextDirection.rtl,
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  //  border:TableBorder.all(width: 2.0,color: Colors.red),
                  columnWidths: const {
                    0: FixedColumnWidth(80),
                    1: FlexColumnWidth(),
                  },

                  children: [
                    TableRow(children: [
                      const Text(
                        "Desc",
                      ),
                      Text(tukangList[index].tukangDesc.toString()),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Phone",
                      ),
                      Text(tukangList[index].tukangPhone.toString()),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Email",
                      ),
                      Text(tukangList[index].tukangEmail.toString()),
                    ]),
                    TableRow(children: [
                      const Text("Date Reg"),
                      Text(formatter.format(DateTime.parse(
                          tukangList[index].tukangDatereg.toString()))),
                    ]),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.phone,
                                size: 48,
                              ),
                              onPressed: () {
                                launchUrlString(
                                    'tel://${tukangList[index].tukangPhone.toString()}');
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.wechat_sharp,
                                size: 48,
                              ),
                              onPressed: () {
                                launchUrlString(
                                    'https://wa.me/+60${tukangList[index].tukangPhone.toString()}');
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.email,
                                size: 48,
                              ),
                              onPressed: () {
                                launchUrlString(
                                    'mailto://+60${tukangList[index].tukangEmail.toString()}');
                              }),
                        ]))
              ],
            ),
          );
        });
  }

  void showSearchDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: const Text('Search'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Field', // Label for the dropdown
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                            height:
                                5), // Add some spacing between the label and the dropdown
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            value: selectedField,
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: fields.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedField = newValue!;
                              print(selectedField);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select District', // Label for the dropdown
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                            height:
                                5), // Add some spacing between the label and the dropdown
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            value: selectedDistrict,
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: districts.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedDistrict = newValue!;
                              print(selectedDistrict);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: ()  {
                             loadTukang();
                              Navigator.pop(context);
                            },
                            child: const Text('Search'))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ));
          });
        });
  }
}
