import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class NewTukangScreen extends StatefulWidget {
  const NewTukangScreen({super.key});

  @override
  State<NewTukangScreen> createState() => _NewTukangScreenState();
}

class _NewTukangScreenState extends State<NewTukangScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
    'Carpenter',
    'Painter',
    'Cleaner',
    'Cook',
    'Driver',
    'Builder',
    'Carpenter',
    'Other'
  ];

  var image;

  String selectedDistrict = 'Baling';
  String selectedField = 'Plumber';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NewTukang'),
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
                                ? const AssetImage('assets/images/profile.png')
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
                      child: const Text('Submit'),
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

    if (image == null || name.isEmpty || email.isEmpty || phone.isEmpty) {
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
    String base64Image = base64Encode(image.readAsBytesSync());
    http.post(Uri.parse('http://10.30.1.39/mytukang/api/insert_tukang.php'),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'field': selectedField,
          'district': selectedDistrict,
          'image': base64Image,
        }).then((response) {
      print(response.body);
    });
  }
}
