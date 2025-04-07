import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mytukang/myconfig.dart';

class NewTukangScreen extends StatefulWidget {
  const NewTukangScreen({Key? key}) : super(key: key);

  @override
  State<NewTukangScreen> createState() => _NewTukangScreenState();
}

class _NewTukangScreenState extends State<NewTukangScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Use XFile for both platforms.
  XFile? image;
  // For web, store image bytes to display and upload.
  Uint8List? webImageBytes;
  String selectedDistrict = 'Baling';
  String selectedField = 'Plumber';

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
  Widget build(BuildContext context) {
    // Adjust form width based on screen size for responsiveness.
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth > 600 ? 600.0 : screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Tukang'),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: formWidth,
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
                          backgroundImage: _buildProfileImage(),
                        ),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt,
                              color: Colors.deepPurpleAccent),
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
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : "Enter a valid email",
                  ),
                  const SizedBox(height: 10),

                  // Phone Field
                  buildInputField(
                    controller: phoneController,
                    label: "Phone",
                    keyboardType: TextInputType.phone,
                    validator: (value) => value != null && value.length >= 10
                        ? null
                        : "Enter a valid phone number",
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
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text("Submit",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build the profile image based on platform.
  ImageProvider _buildProfileImage() {
    if (image != null) {
      if (kIsWeb) {
        // For web, use MemoryImage.
        return MemoryImage(webImageBytes!);
      } else {
        // For mobile, convert XFile to File.
        return FileImage(File(image!.path));
      }
    }
    return const AssetImage('assets/images/profile.png');
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    // On web, use gallery source; on mobile, use camera.
    final pickedFile = await picker.pickImage(
      source: kIsWeb ? ImageSource.gallery : ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        // Read image bytes for web.
        webImageBytes = await pickedFile.readAsBytes();
      }
      setState(() {
        image = pickedFile;
      });
    }
  }

  // Reusable TextField Builder with modern style
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
        hintText: "Enter $label",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
    );
  }

  // Reusable Dropdown Field with modern styling
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }

  void onsubmitDialog() {
    if (!_formKey.currentState!.validate() || image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to submit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              submitData();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void submitData() {
    // Get image bytes depending on the platform.
    final imageBytes =
        kIsWeb ? webImageBytes : File(image!.path).readAsBytesSync();
    http.post(Uri.parse('${MyConfig.baseUrl}/api/insert_tukang.php'), body: {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'field': selectedField,
      'district': selectedDistrict,
      'desc': descController.text,
      'image': base64Encode(imageBytes as List<int>),
    }).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Tukang submitted successfully'),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Submission failed, please try again.'),
              backgroundColor: Colors.red),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
