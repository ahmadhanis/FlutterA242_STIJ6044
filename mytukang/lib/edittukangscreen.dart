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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? image;
  late String selectedDistrict;
  late String selectedField;
  late String tukangId;

  final List<String> districts = [
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

  final List<String> fields = [
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

  @override
  void initState() {
    super.initState();
    tukangId = widget.tukang.tukangId.toString();
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture Picker
              GestureDetector(
                onTap: openCamera,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : NetworkImage(
                                  "${MyConfig.baseUrl}/assets/$tukangId.png")
                              as ImageProvider,
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Name Field
              buildInputField(controller: nameController, label: "Name"),
              const SizedBox(height: 10),

              // Email Field
              buildInputField(
                controller: emailController,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : "Enter a valid email",
              ),
              const SizedBox(height: 10),

              // Phone Field
              buildInputField(
                controller: phoneController,
                label: "Phone",
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.length >= 10 ? null : "Enter a valid phone number",
              ),
              const SizedBox(height: 10),

              // Field Dropdown
              buildDropdownField(
                value: selectedField,
                label: "Field of Work",
                items: fields,
                onChanged: (String? newValue) {
                  setState(() => selectedField = newValue!);
                },
              ),
              const SizedBox(height: 10),

              // Description Field
              buildInputField(
                controller: descController,
                label: "Description",
                maxLines: 5,
              ),
              const SizedBox(height: 10),

              // District Dropdown
              buildDropdownField(
                value: selectedDistrict,
                label: "District",
                items: districts,
                onChanged: (String? newValue) {
                  setState(() => selectedDistrict = newValue!);
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton.icon(
                onPressed: onsubmitDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.update, color: Colors.white),
                label:
                    const Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Builder
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validator,
    );
  }

  // Reusable Dropdown Field
  Widget buildDropdownField({
    required String value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      items: items.map((String item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      setState(() => image = File(pickedFile.path));
    }
  }

  void onsubmitDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    submitData();
  }

  void submitData() {
    http.post(Uri.parse('${MyConfig.baseUrl}/api/update_tukang.php'), body: {
      'tukangid': tukangId,
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'field': selectedField,
      'district': selectedDistrict,
      'desc': descController.text,
      'image': image == null ? "NA" : base64Encode(image!.readAsBytesSync()),
    }).then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Tukang updated successfully'),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    });
  }
}
