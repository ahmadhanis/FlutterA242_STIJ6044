import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytukang/myconfig.dart';
import 'package:mytukang/newtukangscreen.dart';
import 'package:mytukang/tukang.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class TukangScreen extends StatefulWidget {
  const TukangScreen({super.key});

  @override
  State<TukangScreen> createState() => _TukangScreenState();
}

class _TukangScreenState extends State<TukangScreen> {
  List<Tukang> tukangList = <Tukang>[]; // List of tukang objects
  String status = "Loading...";
  late double screenHeight, screenWidth;
  DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;
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
    super.initState();
    loadTukang();
  }

  Future<void> loadTukang() async {
    await http
        .get(Uri.parse(
            '${MyConfig.baseUrl}/api/load_tukang.php?district=$selectedDistrict&field=$selectedField&pageno=$curpage'))
        .then((response) {
      var data = jsonDecode(response.body);
      // log(data.toString());
      if (data['status'] == 'success') {
        tukangList.clear();
        data['data'].forEach((tukang) {
          Tukang t = Tukang.fromJson(tukang);
          tukangList.add(t);
        });
        numofpage = int.parse(data['numofpage'].toString());
        numofresult = int.parse(data['numberofresult'].toString());
        print(numofpage);
        print(numofresult);
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await loadTukang();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data updated'),
                      backgroundColor: Colors.purple,
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth < 600 ? 1 : 2,
                          childAspectRatio: screenWidth < 600 ? 3.5 : 3.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: tukangList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onLongPress: () {
                                showDeleteDialog(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "${MyConfig.baseUrl}/assets/${tukangList[index].tukangId}.png",
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            tukangList[index]
                                                .tukangName
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${tukangList[index].tukangField}\n${tukangList[index].tukangLocation}\n${tukangList[index].tukangField}\n${tukangList[index].tukangPhone}',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => showTukangDetails(index),
                                      icon: const Icon(Icons.info_outline),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Page: $curpage/Result: $numofresult"),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: numofpage,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          color = ((curpage - 1) == index)
                              ? Colors.red
                              : Colors.black;
                          return TextButton(
                            onPressed: () {
                              curpage = index + 1;
                              loadTukang();
                            },
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: color, fontSize: 18),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTukangScreen()),
          );
          loadTukang();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Modern bottom sheet for search filters
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  loadTukang();
                                  Navigator.pop(context);
                                },
                                child: const Text('Search')),
                            ElevatedButton(
                                onPressed: () {
                                  selectedDistrict = 'All';
                                  selectedField = 'All';
                                  loadTukang();
                                  Navigator.pop(context);
                                },
                                child: const Text('Reset'))
                          ],
                        )
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

  // Modern dialog for displaying tukang details
  showTukangDetails(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${MyConfig.baseUrl}/assets/${tukangList[index].tukangId}.png",
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    tukangList[index].tukangName.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(80),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Desc",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(tukangList[index].tukangDesc.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Phone",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(tukangList[index].tukangPhone.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Email",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(tukangList[index].tukangEmail.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Date Reg",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(formatter.format(DateTime.parse(
                              tukangList[index].tukangDatereg.toString()))),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.phone,
                          size: 36,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          launchUrlString(
                              'tel://${tukangList[index].tukangPhone.toString()}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wechat,
                          size: 36,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          launchUrlString(
                              'https://wa.me/+60${tukangList[index].tukangPhone.toString()}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.email,
                          size: 36,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          launchUrlString(
                              'mailto://+60${tukangList[index].tukangEmail.toString()}');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showDeleteDialog(int index) {
    TextEditingController passController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Tukang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurpleAccent, width: 2.0),
                    ),
                  )),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await deleteTukang(tukangList[index].tukangId.toString(),
                    passController.text, context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteTukang(
      String string, String pass, BuildContext context) async {
    await http
        .post(Uri.parse("${MyConfig.baseUrl}/api/delete_tukang.php"), body: {
      'tukang_id': string,
      'password': pass,
    }).then((response) {
      var data = jsonDecode(response.body);
      log(data.toString());
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tukang deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        loadTukang();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete tukang'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
