import 'package:flutter/material.dart';
import 'package:tbibi/models/user.dart';

class EditProfilePage extends StatefulWidget {
  final User doctor;
  const EditProfilePage({Key? key, required this.doctor}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<TextEditingController> phoneControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the doctor's information when the widget is created.
    nameController.text = widget.doctor.fullName;
    jobController.text = widget.doctor.specialty;
    emailController.text = widget.doctor.email;
    locationController.text = widget.doctor.adress;
    phoneControllers[0].text = widget.doctor.phone.toString();
  }

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
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  backgroundImage: AssetImage(
                    widget.doctor.imageUrl,
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
                const SizedBox(height: 16),
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
    // Dispose of the controllers when the widget is removed.
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
