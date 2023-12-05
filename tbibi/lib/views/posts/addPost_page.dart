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
  bool _uploading = false;

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
      var imageURL = null; // Initialize imageURL with an empty string

      if (_pickedImage != null) {
        imageURL = await _uploadImage();
      }

      String postId = _firestore
          .collection(userDocumentPath)
          .doc()
          .id; // Generate a unique ID

      Map<String, dynamic> updatedData = {
        'postId': postId, // Add the post ID to the data
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dateTime': DateTime.now().toString(),
        'userId': userId,
        'image': imageURL,
      };

      if (_titleController.text.isNotEmpty ||
          _descriptionController.text.isNotEmpty) {
        await _firestore
            .collection(userDocumentPath)
            .doc(postId)
            .set(updatedData); // Set document with the specific post ID

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: _descriptionController,
              style: TextStyle(fontSize: 18.0),
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 18.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: _uploading ? null : _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                  image: _pickedImage != null
                      ? DecorationImage(
                          image: FileImage(_pickedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _pickedImage == null
                    ? Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.grey[500],
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _uploading ? null : () => _addPostToFirebase(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Color(0xFF4163CD),
              ),
              child: _uploading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Add Post',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 254, 254, 254)),
                    ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
