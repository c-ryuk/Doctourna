import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ConfirmationListPage extends StatefulWidget {
  @override
  _ConfirmationListPageState createState() => _ConfirmationListPageState();
}

class _ConfirmationListPageState extends State<ConfirmationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor List"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('isDoctor', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<DocumentSnapshot> doctorList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctorList.length,
            itemBuilder: (context, index) {
              var doctor = doctorList[index];
              bool isActivated = doctor['isActivated'] ?? false;

              return Card(
                color: isActivated ? Colors.white : Colors.red,
                child: ListTile(
                  title: Text(doctor['username'] ?? ''),
                  subtitle: Text(doctor['email'] ?? ''),
                  trailing: isActivated
                      ? null
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(doctor.id)
                                .update({'isActivated': true});

                            await _sendConfirmationEmail(doctor['email'] ?? '');

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'User activation updated and confirmation email sent.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _sendConfirmationEmail(String to) async {
    final smtpServer = gmail("djangotp1@gmail.com", "zgxmpxojgsbezyoy");

    final message = Message()
      ..from = Address("djangotp1@gmail.com")
      ..recipients.add(to)
      ..subject = "Your Request Has Been Confirmed"
      ..text =
          "We have confirmed your request. You can now access your account.";

    try {
      await send(message, smtpServer);
      print('Confirmation email sent successfully');
    } catch (e) {
      print('Error sending confirmation email: $e');
    }
  }
}
