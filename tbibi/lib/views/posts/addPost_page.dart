// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AddPostPage({Key? key, required this.userData}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _pickedImage;

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
      String imagePath = 'post_images/${_titleController.text}.png';

      await storage.ref(imagePath).putFile(_pickedImage!);

      String downloadURL = await storage.ref(imagePath).getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  Future<void> _addPostToFirebase() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      String userId = widget.userData['uid'];
      String userDocumentPath = 'blog';
      String imageURL = ''; // Initialize imageURL with an empty string

      if (_pickedImage != null) {
        imageURL = await _uploadImage();
      }

      Map<String, dynamic> updatedData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dateTime': DateTime.now().toString(),
        'userId': userId,
        'image': imageURL,
      };

      if (_titleController.text.isNotEmpty ||
          _descriptionController.text.isNotEmpty) {
        await _firestore.collection(userDocumentPath).add(updatedData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'Post added successfully!',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
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
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 70,
              backgroundImage: _pickedImage != null
                  ? FileImage(_pickedImage!)
                  : AssetImage('assets/Doc_icon.jpg')
                      as ImageProvider, // Cast en ImageProvider
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF4163CD),
              ),
              child: Text('Pick Image'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _addPostToFirebase();
              },
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
