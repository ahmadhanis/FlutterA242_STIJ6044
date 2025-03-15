import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytukang/edittukangscreen.dart';
import 'package:mytukang/myconfig.dart';
import 'package:mytukang/newtukangscreen.dart';
import 'package:mytukang/tukang.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  List fav = [];

  String selectedDistrict = 'All';
  String selectedField = 'All';

  @override
  void initState() {
    super.initState();
    loadFav();
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
              colors: [Colors.blueAccent, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              showFavTukang();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await loadTukang();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data updated'),
                  backgroundColor: Colors.blueGrey,
                  duration: Duration(milliseconds: 500),
                ),
              );
            },
          ),
        ],
      ),
      body: tukangList.isEmpty
          ? Center(
              child: status == "Loading..."
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const CircularProgressIndicator(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(status)
                        ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sentiment_dissatisfied,
                            size: 50, color: Colors.blueGrey),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(status),
                      ],
                    ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await loadTukang();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data updated'),
                      backgroundColor: Colors.blueGrey,
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(4),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth < 600 ? 1 : 2,
                          childAspectRatio: screenWidth < 600 ? 2.7 : 3.0,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
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
                              onTap: () {
                                showTukangDetails(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "${MyConfig.baseUrl}/assets/${tukangList[index].tukangId}.png",
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Tukang Name with Modern Styling
                                            Text(
                                              tukangList[index]
                                                  .tukangName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 4),

                                            // Star Rating Logic
                                            tukangList[index].tukangRating == 0
                                                ? const Text(
                                                    "No rating available",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  )
                                                : RatingBarIndicator(
                                                    rating: double.parse(
                                                        tukangList[index]
                                                            .tukangRating
                                                            .toString()),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 16,
                                                  ),
                                            const SizedBox(height: 6),

                                            // Tukang Field with Icon
                                            Row(
                                              children: [
                                                const Icon(Icons.work_outline,
                                                    size: 16,
                                                    color: Colors.deepPurple),
                                                const SizedBox(width: 6),
                                                Text(
                                                  tukangList[index]
                                                      .tukangField
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),

                                            // Tukang Location with Icon
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    size: 16,
                                                    color: Colors.redAccent),
                                                const SizedBox(width: 6),
                                                Text(
                                                  tukangList[index]
                                                      .tukangLocation
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),

                                            // Tukang Phone with Icon
                                            Row(
                                              children: [
                                                const Icon(Icons.phone,
                                                    size: 16,
                                                    color: Colors.green),
                                                const SizedBox(width: 6),
                                                Text(
                                                  tukangList[index]
                                                      .tukangPhone
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (!fav.contains(int.parse(
                                                tukangList[index]
                                                    .tukangId
                                                    .toString()))) {
                                              fav.add(
                                                  tukangList[index].tukangId);
                                              storPref(fav);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Tukang added to favorite'),
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                ),
                                              );
                                              setState(() {});
                                            } else {
                                              fav.remove(int.parse(
                                                  tukangList[index]
                                                      .tukangId
                                                      .toString()));
                                              storPref(fav);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Tukang removed from favorite'),
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                ),
                                              );
                                              setState(() {});
                                            }
                                          },
                                          icon: Icon(
                                            fav.contains(int.parse(
                                                    tukangList[index]
                                                        .tukangId
                                                        .toString()))
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: fav.contains(int.parse(
                                                    tukangList[index]
                                                        .tukangId
                                                        .toString()))
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showReportDialog(index);
                                          },
                                          icon: const Icon(Icons.report),
                                        ),
                                      ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.pages,
                              color: Colors.blueGrey, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            "Page: $curpage • Results: $numofresult",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
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
        backgroundColor: Colors.blueGrey,
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
  void showTukangDetails(int index) {
    double userRating = 0; // Default rating

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
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Star Rating Display (Existing Rating)
                  tukangList[index].tukangRating == 0
                      ? const Text(
                          "No ratings yet",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      : RatingBarIndicator(
                          rating: double.parse(
                              tukangList[index].tukangRating.toString()),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                        ),
                  const SizedBox(height: 10),

                  // Tukang Details Table
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(80),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("Desc",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(tukangList[index].tukangDesc.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("Phone",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(tukangList[index].tukangPhone.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("Email",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(tukangList[index].tukangEmail.toString()),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("Date Reg",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(formatter.format(DateTime.parse(
                              tukangList[index].tukangDatereg.toString()))),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Star Rating Submission
                  const Text(
                    "Rate this Tukang:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (userRating > 0) {
                        submitTukangRating(
                            tukangList[index].tukangId.toString(), userRating);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Rating submitted successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please select a rating before submitting.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Submit Rating",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contact Options
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
                              'mailto:${tukangList[index].tukangEmail.toString()}');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Function to Submit Rating
  void submitTukangRating(String tukangId, double rating) {
    http.post(
      Uri.parse('${MyConfig.baseUrl}/api/submit_rating.php'),
      body: {
        'tukangid': tukangId,
        'rating': rating.toString(),
      },
    ).then((response) {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        debugPrint(result.toString());
        if (result['status'] == 'success') {
          debugPrint('Rating submitted successfully');
          loadTukang();
        } else {
          debugPrint('Failed to submit rating');
        }
      }
    });
  }

  void showDeleteDialog(int index) {
    TextEditingController passController = TextEditingController();
    bool isPasswordVisible = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              title: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.redAccent, size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Delete/Update Tukang',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tukangList[index].tukangName.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Password Field with Visibility Toggle
                  TextFormField(
                    controller: passController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      prefixIcon: const Icon(Icons.lock,
                          color: Colors.deepPurpleAccent),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.black54),
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    updateTukang(
                      tukangList[index].tukangId.toString(),
                      passController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('Update',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await deleteTukang(
                      tukangList[index].tukangId.toString(),
                      passController.text,
                      context,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Delete',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
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

  void updateTukang(String tukangid, String pass) {
    http.post(Uri.parse("${MyConfig.baseUrl}/api/cari_tukang.php"), body: {
      'tukang_id': tukangid,
      'password': pass,
    }).then((response) async {
      var data = jsonDecode(response.body);
      // log(response.body.toString());
      if (data['status'] == 'success') {
        Tukang tukang = Tukang.fromJson(data['data'][0]);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTukangScreen(tukang: tukang),
          ),
        );
        loadTukang();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> storPref(List fav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorite', '');
    await prefs.setString('favorite', fav.toString());
    loadFav();
    setState(() {});
  }

  Future<void> loadFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favString = prefs.getString('favorite');
    fav = [];
    if (favString != null && favString.isNotEmpty) {
      fav = List.from(json.decode(favString));
    } else {
      fav = [];
    }
  }

  Future<void> showFavTukang() async {
    if (fav.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No favorite tukang found'),
          backgroundColor: Colors.red,
        ),
      );
    }
    print('${MyConfig.baseUrl}/api/load_fav.php?fav=${fav.toString()}');
    await http
        .get(Uri.parse('${MyConfig.baseUrl}/api/load_fav.php?fav=$fav'))
        .then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      log(data.toString());
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

  void showReportDialog(int index) {
    TextEditingController reasonController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          title: const Row(
            children: [
              Icon(Icons.report_problem, color: Colors.redAccent, size: 28),
              SizedBox(width: 10),
              Text(
                'Report Tukang',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tukangList[index].tukangName.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please provide a reason for reporting this Tukang:',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 10),

                // TextField for Report Reason
                TextFormField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter reason...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Reason cannot be empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  reportTukang(
                    tukangList[index].tukangId.toString(),
                    reasonController.text.trim(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  const Text('Report', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> reportTukang(String tukangid, String trim) async {
    await http
        .post(Uri.parse("${MyConfig.baseUrl}/api/report_tukang.php"), body: {
      'tukangid': tukangid,
      'reason': trim,
    }).then((response) {
      var data = jsonDecode(response.body);
      print(response.body);
      log(data.toString());
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tukang reported successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to report tukang'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
