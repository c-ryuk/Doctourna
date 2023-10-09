import 'package:flutter/material.dart';
import 'package:tbibi/models/doctor.dart';
import 'package:tbibi/widgets/doctor_box.dart';

class DoctorsListPage extends StatefulWidget {
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List symptoms = [
    "Heart",
    "Sexologist",
    "Radiologist",
    "Oncologist",
    "Surgeon",
  ];

  final List<Doctor> allDoctors = [
    Doctor(
        name: 'Dr. Hamed TRIKI',
        imageUrl: 'assets/hamed.jpg',
        speciality: 'Generalist',
        rating: '4.7'),
    Doctor(
        name: 'Dr. Mohamed MISSAMOUI',
        imageUrl: 'assets/missa.jpg',
        speciality: 'Generalist',
        rating: '4.7'),
    Doctor(
        name: 'Dr. Hamza REKIK',
        imageUrl: 'assets/hamza.png',
        speciality: 'Generalist',
        rating: '4.7'),
  ];

  List<Doctor> filteredDoctors = [];
  String selectedSymptom = "";

  @override
  void initState() {
    super.initState();
    filteredDoctors.addAll(allDoctors);
  }

  void _filterDoctors(String query) {
    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        final doctorName = doctor.name.toLowerCase();
        return doctorName.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterDoctors,
                decoration: InputDecoration(
                  labelText: 'Search Doctors',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFF4163CD),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "What are your issue?",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  final currentSymptom = symptoms[index];
                  final isSelected = currentSymptom == selectedSymptom;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentSymptom == selectedSymptom) {
                          selectedSymptom = "";
                        } else {
                          selectedSymptom = currentSymptom;
                        }
                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Color(0xFF4163CD) : Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          currentSymptom,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 35)),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Popular Doctors",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final doctor = filteredDoctors[index];
              return DoctorBox(doctor: doctor);
            }, childCount: filteredDoctors.length),
          ),
        ],
      ),
    );
  }
}
