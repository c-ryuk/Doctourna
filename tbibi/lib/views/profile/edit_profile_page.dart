import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  File? _pickedImage;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String milliseconds = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath = 'user_images/$milliseconds.png';

      await storage.ref(imagePath).putFile(_pickedImage!);

      String downloadURL = await storage.ref(imagePath).getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  String? _validateExperience(String? value) {
    if (widget.userData['isDoctor'] == true && value == null ||
        value!.isEmpty) {
      return 'Experience is required for doctors';
    }
    return null;
  }

  String? _validateJob(String? value) {
    if (widget.userData['isDoctor'] == true && value == null ||
        value!.isEmpty) {
      return 'Speciality is required for doctors';
    }
    return null;
  }

  String? _validateConsultation(String? value) {
    if (widget.userData['isDoctor'] == true && value == null ||
        value!.isEmpty) {
      return 'Consultation Price is required for doctors';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validateAbout(String? value) {
    if (value == null || value.isEmpty) {
      return 'About Me is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  Future<void> saveProfile() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      String userId = widget.userData['uid'];
      String userDocumentPath = 'users/$userId';

      if (_pickedImage != null) {
        String imageURL = await _uploadImage();
        widget.userData['image'] = imageURL;
      }

      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> updatedData = {
          'username': nameController.text,
          'speciality':
              widget.userData['isDoctor'] == true ? jobController.text : null,
          'location': locationController.text,
          'phoneNumber': phoneController.text,
          'about': aboutController.text,
          'experience': widget.userData['isDoctor'] == true
              ? int.parse(experienceController.text)
              : null,
          'consultationPrice': widget.userData['isDoctor'] == true
              ? int.parse(consultationPriceController.text)
              : null,
          'image': widget.userData['image'],
        };

        if (widget.userData['isDoctor'] == true &&
            widget.userData['isDoctor'] != null) {
          if (nameController.text.isNotEmpty ||
              jobController.text.isNotEmpty ||
              locationController.text.isNotEmpty ||
              phoneController.text.isNotEmpty ||
              aboutController.text.isNotEmpty ||
              experienceController.text.isNotEmpty ||
              consultationPriceController.text.isNotEmpty) {
            await _firestore.doc(userDocumentPath).update(updatedData);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Please fill all the fields!',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else if (widget.userData['isDoctor'] == false &&
            widget.userData['isDoctor'] != null) {
          if (nameController.text.isNotEmpty ||
              locationController.text.isNotEmpty ||
              phoneController.text.isNotEmpty ||
              aboutController.text.isNotEmpty) {
            await _firestore.doc(userDocumentPath).update(updatedData);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Please fill all the fields!',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
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

        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/profile-page');
      }
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userData['username'] ?? '';
    jobController.text = widget.userData['speciality'] ?? '';
    locationController.text = widget.userData['location'] ?? '';
    phoneController.text = widget.userData['phoneNumber'] ?? '00';
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 70,
                    backgroundImage: widget.userData['image'] != null
                        ? NetworkImage(
                            widget.userData['image'],
                          ) as ImageProvider
                        : AssetImage('assets/Doc_icon.jpg'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        enabled: isEditing,
                        errorText: _validateName(nameController.text)),
                    validator: _validateName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (widget.userData['isDoctor'] == true &&
                      widget.userData['isDoctor'] != null)
                    TextFormField(
                      controller: jobController,
                      decoration: InputDecoration(
                        labelText: 'Speciality',
                        enabled: isEditing,
                        errorText: _validateJob(jobController.text),
                      ),
                      validator: _validateJob,
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
                          errorText:
                              _validateLocation(locationController.text)),
                      validator: _validateLocation,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          labelText: "Phone Number",
                          enabled: isEditing,
                          errorText: _validatePhone(phoneController.text)),
                      validator: _validatePhone,
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  if (widget.userData['isDoctor'] == true &&
                      widget.userData['isDoctor'] != null)
                    ListTile(
                      leading: Icon(Icons.align_vertical_bottom_sharp),
                      title: TextFormField(
                        controller: experienceController,
                        decoration: InputDecoration(
                          labelText: 'Experience',
                          enabled: isEditing,
                          errorText:
                              _validateExperience(experienceController.text),
                        ),
                        validator: _validateExperience,
                      ),
                    ),
                  if (widget.userData['isDoctor'] == true &&
                      widget.userData['isDoctor'] != null)
                    ListTile(
                      leading: Icon(Icons.price_change),
                      title: TextFormField(
                        controller: consultationPriceController,
                        decoration: InputDecoration(
                            labelText: 'Consultation Price',
                            enabled: isEditing,
                            errorText: _validateConsultation(
                                consultationPriceController.text)),
                        validator: _validateConsultation,
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
                        errorText: _validateAbout(aboutController.text),
                      ),
                      validator: _validateAbout,
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
