// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: 'Hamed TRIKI');
  TextEditingController jobController = TextEditingController(text: 'Surgeon');
  TextEditingController emailController =
      TextEditingController(text: 'hamedtriki@example.com');
  TextEditingController locationController =
      TextEditingController(text: 'Burkina Sfaxou, Tun');

  List<TextEditingController> phoneControllers = [
    TextEditingController(text: '+216 33070')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://img.a.transfermarkt.technology/portrait/big/28003-1694590254.jpg?lm=1',
                  ),
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
                    labelText: 'speciality',
                    enabled: isEditing,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      enabled: isEditing,
                    ),
                  ),
                ),
                Column(
                  children: phoneControllers.map((phoneController) {
                    return ListTile(
                      leading: Icon(Icons.phone),
                      title: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          enabled: isEditing,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (isEditing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            phoneControllers.add(TextEditingController());
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (phoneControllers.length > 1) {
                              phoneControllers.removeLast();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      enabled: isEditing,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  child: Text(isEditing ? 'Save' : 'Edit Profile'),
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
    emailController.dispose();
    locationController.dispose();
    for (var controller in phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
