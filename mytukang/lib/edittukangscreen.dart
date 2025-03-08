import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytukang/myconfig.dart';
import 'package:mytukang/tukang.dart';

class EditTukangScreen extends StatefulWidget {
  final Tukang tukang;
  const EditTukangScreen({super.key, required this.tukang});

  @override
  State<EditTukangScreen> createState() => _EditTukangScreenState();
}

class _EditTukangScreenState extends State<EditTukangScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var districts = [
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

  File? image;

  String selectedDistrict = '';
  String selectedField = '';
  String tukangid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tukangid = widget.tukang.tukangId.toString();
    emailController.text = widget.tukang.tukangEmail.toString();
    phoneController.text = widget.tukang.tukangPhone.toString();
    nameController.text = widget.tukang.tukangName.toString();
    descController.text = widget.tukang.tukangDesc.toString();
    selectedDistrict = widget.tukang.tukangLocation.toString();
    selectedField = widget.tukang.tukangField.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Tukang'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      openCamera();
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          image: DecorationImage(
                            image: image == null
                                ? NetworkImage(
                                    "${MyConfig.baseUrl}/assets/$tukangid.png")
                                : FileImage(image!) as ImageProvider<Object>,
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
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
                  TextField(
                    maxLines: 5,
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
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
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        onsubmitDialog();
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    setState(() {});
  }

  void onsubmitDialog() {
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String desc = descController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!email.contains('@') && !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to submit?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
                  submitData();
                },
              ),
            ],
          );
        });
  }

  void submitData() {
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String desc = descController.text;
    String image64 = "";
    if (image == null) {
      image64 = "NA";
    } else {
      image64 = base64Encode(image!.readAsBytesSync());
    }
    http.post(Uri.parse('${MyConfig.baseUrl}/api/update_tukang.php'), body: {
      'tukangid': tukangid,
      'name': name,
      'email': email,
      'phone': phone,
      'field': selectedField,
      'district': selectedDistrict,
      'desc': desc,
      'image': image64,
    }).then((response) {
      if (response.statusCode == 200) {
        // print(response.body);
        var arrayresponse = jsonDecode(response.body);
        if (arrayresponse['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tukang update successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update tukang'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }
}
