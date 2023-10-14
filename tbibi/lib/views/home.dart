import 'package:flutter/material.dart';
import 'package:tbibi/models/user.dart';
import 'package:tbibi/static_data/users_list.dart';
import 'package:tbibi/widgets/doctor_box.dart';

class DoctorsListPage extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  DoctorsListPage({required this.toggleTheme, required this.isDarkMode});

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<User> filteredDoctors = [];
  String selectedSpecialty = 'All';
  String nameFilter = '';

  List<String> specialties = [
    'All',
    'Dentiste',
    'Généraliste',
    'Cardiologue',
    'Specialty4',
    'Specialty5'
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = Users_data.where((user) => user.isDoctor).toList();
  }

  void _filterDoctorsBySpecialty(String specialty) {
    setState(() {
      selectedSpecialty = specialty;
      _applyFilters();
    });
  }

  void _filterDoctors(String query) {
    setState(() {
      nameFilter = query;
      _applyFilters();
    });
  }

  void _applyFilters() {
    filteredDoctors = Users_data.where((user) {
      final specialtyMatch = selectedSpecialty == 'All' ||
          user.specialty
              .toLowerCase()
              .contains(selectedSpecialty.toLowerCase());

      final nameMatch = nameFilter.isEmpty ||
          user.fullName.toLowerCase().contains(nameFilter.toLowerCase());

      return user.isDoctor && specialtyMatch && nameMatch;
    }).toList();
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
                "What did you want?",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialties.length,
                  itemBuilder: (context, index) {
                    final specialty = specialties[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _filterDoctorsBySpecialty(specialty);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: specialty == selectedSpecialty
                                ? Color(0xFF4163CD)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              specialty,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
              return DoctorBox(
                doctor: doctor,
                toggleTheme: widget.toggleTheme,
                isDarkMode: widget.isDarkMode,
              );
            }, childCount: filteredDoctors.length),
          ),
          if (filteredDoctors.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "NO DOCTORS FOUND RELATED TO YOUR SEARCH",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4163CD),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
