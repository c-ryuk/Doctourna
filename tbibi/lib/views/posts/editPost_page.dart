// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditPostPage extends StatefulWidget {
  final Map<String, dynamic> post;
  const EditPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<EditPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post['title'] ?? '';
    _descriptionController.text = widget.post['description'] ?? '';
  }

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
      String postId = widget.post['postId'];

      String userDocumentPath = 'blog/$postId';
      String imageURL = ''; // Initialize imageURL with an empty string

      if (_pickedImage != null) {
        imageURL = await _uploadImage();
      }

      Map<String, dynamic> updatedData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dateTime': DateTime.now().toString(),
        'image': imageURL,
      };

      if (_titleController.text.isNotEmpty ||
          _descriptionController.text.isNotEmpty) {
        await _firestore.doc(userDocumentPath).update(updatedData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'Post updated successfully!',
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
      print('Error updating post: $error');
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
                  : NetworkImage(widget.post['image'])
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
              child: Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
