import 'dart:io';
import 'package:flutter/material.dart';

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

  File? image;

  String selectedDistrict = 'Baling';

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
                  Container(
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
                      onPressed: () {},
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
