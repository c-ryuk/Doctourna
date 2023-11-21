import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController consultationPriceController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.userData['image'] = pickedFile.path;
      });
    }
  }

  void saveProfile() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      String userId = widget.userData['uid'];
      String userDocumentPath = 'users/$userId';

      Map<String, dynamic> updatedData = {
        'username': nameController.text,
        'speciality': jobController.text,
        'location': locationController.text,
        'phoneNumber': phoneController.text,
        'about': aboutController.text,
        'experience': int.parse(experienceController.text),
        'consultationPrice': int.parse(consultationPriceController.text),
      };

      if (widget.userData['image'] != null) {
        updatedData['image'] = widget.userData['image'];
      }

      await _firestore.doc(userDocumentPath).update(updatedData);

      await Future.delayed(Duration(seconds: 1), () {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'Profile updated successfully!',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      });
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/profile-page');
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userData['username'] ?? '';
    jobController.text = widget.userData['specialty'] ?? '';
    locationController.text = widget.userData['location'] ?? '';
    phoneController.text = widget.userData['phoneNumber'] ?? 00;
    aboutController.text = widget.userData['about'] ?? '';
    experienceController.text = widget.userData['experience'].toString();
    consultationPriceController.text =
        widget.userData['consultationPrice'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Color(0xFF4163CD),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  backgroundImage: widget.userData['image'] != null
                      ? FileImage(File(widget.userData['image']))
                          as ImageProvider
                      : AssetImage('assets/Doc_icon.jpg'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    enabled: isEditing,
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: jobController,
                  decoration: InputDecoration(
                    labelText: 'Speciality',
                    enabled: isEditing,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      enabled: isEditing,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      enabled: isEditing,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.align_vertical_bottom_sharp),
                  title: TextFormField(
                    controller: experienceController,
                    decoration: InputDecoration(
                      labelText: 'Experience',
                      enabled: isEditing,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.price_change),
                  title: TextFormField(
                    controller: consultationPriceController,
                    decoration: InputDecoration(
                      labelText: 'Consultation Price',
                      enabled: isEditing,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: TextFormField(
                    controller: aboutController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'About Me',
                      enabled: isEditing,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isEditing ? _pickImage : null,
                  child: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4163CD),
                    onPrimary: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                      if (!isEditing) {
                        saveProfile();
                      }
                    });
                  },
                  child: Text(isEditing ? 'Save' : 'Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    primary: isEditing ? Colors.green : Color(0xFF4163CD),
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    aboutController.dispose();
    locationController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    consultationPriceController.dispose();
    super.dispose();
  }
}
