import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to our Doctor Appointment Booking App!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to provide a convenient platform for patients to book appointments with doctors. We aim to make healthcare access easier and more efficient.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email: contact@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone: 22 555 666'),
            ),
            SizedBox(height: 16),
            Text(
              'Our Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/hamed.jpg'),
              ),
              title: Text('Hamed Triki'),
              subtitle: Text('Developper'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/mohamed.png'),
              ),
              title: Text('Mohamed Missaoui'),
              subtitle: Text('Developper'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/hamza.png'),
              ),
              title: Text('Hamza Rekik'),
              subtitle: Text('Developper'),
            ),
          ],
        ),
      ),
    );
  }
}
