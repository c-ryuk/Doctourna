import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentListPatients extends StatefulWidget {
  @override
  _AppointmentListPatientsState createState() =>
      _AppointmentListPatientsState();
}

class _AppointmentListPatientsState extends State<AppointmentListPatients> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String patientId;

  @override
  void initState() {
    super.initState();

    patientId = _auth.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Color(0xFF4163CD),
      ),
      body: FutureBuilder(
        future: _fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data?.isEmpty ?? true) {
            return Center(child: Text('No appointments available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var appointment = snapshot.data?[index];

                Color statusColor = _getStatusColor(appointment?['status']);

                return _buildAppointmentCard(appointment, statusColor);
              },
            );
          }
        },
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'in progress':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildAppointmentCard(
      Map<String, dynamic>? appointment, Color statusColor) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          'Appointment Date: ${_formatDateTime(appointment?['dateTime'])}',
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfoWidget(appointment?['doctorId']),
            Text(
              'Additional Info: ${appointment?['additionalInfo']}',
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _showEditDialog(appointment?['appointmentId']);
          },
        ),
        tileColor: statusColor,
      ),
    );
  }

  Widget _buildPatientInfoWidget(String? doctorId) {
    return FutureBuilder(
      future: _fetchDoctorInfo(doctorId),
      builder: (context, patientSnapshot) {
        if (patientSnapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading doctor info...');
        } else if (patientSnapshot.hasError) {
          return Text('Error: ${patientSnapshot.error}');
        } else {
          var patientInfo = patientSnapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Doctor Name: ${patientInfo?['username']}'),
            ],
          );
        }
      },
    );
  }

  String _formatDateTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'N/A';
    }

    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  Future<List<Map<String, dynamic>>> _fetchAppointments() async {
    try {
      QuerySnapshot appointmentSnapshot = await _firestore
          .collection('appointments')
          .where('patientId', isEqualTo: patientId)
          .get();

      return appointmentSnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> _fetchDoctorInfo(String? doctorId) async {
    try {
      DocumentSnapshot patientSnapshot =
          await _firestore.collection('users').doc(doctorId).get();

      return patientSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching doctorId info: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>?> _fetchAppointmentDetails(
      String? appointmentId) async {
    try {
      if (appointmentId != null) {
        DocumentSnapshot appointmentSnapshot = await _firestore
            .collection('appointments')
            .doc(appointmentId)
            .get();

        if (appointmentSnapshot.exists) {
          return appointmentSnapshot.data() as Map<String, dynamic>;
        } else {
          print('Error: Appointment document does not exist.');
          return null;
        }
      } else {
        print('Error: AppointmentId is null.');
        return null;
      }
    } catch (e) {
      print('Error fetching appointment details: $e');
      return null;
    }
  }

  Future<void> _showEditDialog(String? appointmentId) async {
    Map<String, dynamic>? appointment =
        await _fetchAppointmentDetails(appointmentId);

    if (appointment != null) {
      String newStatus =
          (appointment['status'] == 'in progress') ? 'canceled' : 'in progress';

      await _updateAppointmentStatus(appointmentId, newStatus);

      setState(() {});

      await Future.delayed(Duration(seconds: 1), () {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF4163CD),
            content: Text(
              'Appointment status updated successfully!',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      });
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating appointment status. Please try again.'),
        ),
      );
    }
  }

  Future<void> _updateAppointmentStatus(
      String? appointmentId, String newStatus) async {
    try {
      DocumentSnapshot appointmentSnapshot =
          await _firestore.collection('appointments').doc(appointmentId).get();

      if (appointmentSnapshot.exists) {
        await _firestore.collection('appointments').doc(appointmentId).update({
          'status': newStatus,
        });
      } else {
        print('Error: Appointment document does not exist.');
      }
    } catch (e) {
      print('Error updating appointment status: $e');
    }
  }
}
