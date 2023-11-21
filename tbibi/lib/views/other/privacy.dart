import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatefulWidget {
  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool allowLocation = true;
  bool allowNotifications = false;
  bool allowTracking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Location Privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Allow location access'),
              value: allowLocation,
              onChanged: (bool newValue) {
                setState(() {
                  allowLocation = newValue;
                });
              },
            ),
            Divider(),
            Text(
              'Notifications Privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Allow push notifications'),
              value: allowNotifications,
              onChanged: (bool newValue) {
                setState(() {
                  allowNotifications = newValue;
                });
              },
            ),
            Divider(),
            Text(
              'Tracking Privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Allow usage tracking'),
              value: allowTracking,
              onChanged: (bool newValue) {
                setState(() {
                  allowTracking = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
