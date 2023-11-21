import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tbibi/widgets/doctor_box.dart';

class DoctorsListPage extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  DoctorsListPage({required this.toggleTheme, required this.isDarkMode});

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<Map<String, dynamic>> doctorsData = [];
  List<Map<String, dynamic>> filteredDoctors = [];
  String selectedSpecialty = 'All';
  String selectedGovernment = 'All';
  String nameFilter = '';
  TextEditingController _searchController = TextEditingController();
  List<String> specialties = [
    'All',
    'Dentiste',
    'Généraliste',
    'Cardiologue',
    'spécialité',
    'Specialty5'
  ];

  List<String> governments = [
    'All',
    'Ariana',
    'Beja',
    'Ben Arous',
    'Bizerte',
    'Gabes',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kebili',
    'Kef',
    'Mahdia',
    'Manouba',
    'Medenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];

  List<String> experienceFilters = [
    'All',
    'Under 5 years',
    'Under 10 years',
    'Under 15 years',
    '15 years and above',
  ];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    setState(() {
      doctorsData = querySnapshot.docs
          .where((doc) => doc.id != currentUserId)
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      _applyFilters();
    });
  }

  void _filterDoctors(String query) {
    setState(() {
      nameFilter = query;
      _applyFilters();
    });
  }

  void _filterDoctorsBySpecialty(String specialty) {
    setState(() {
      selectedSpecialty = specialty;
      _applyFilters();
    });
  }

  void _filterDoctorsByGovernment(String government) {
    setState(() {
      selectedGovernment = government;
      _applyFilters();
    });
  }

  String selectedExperienceFilter = 'All';

  void _filterDoctorsByExperience(String experience) {
    setState(() {
      selectedExperienceFilter = experience;
      _applyFilters();
    });
  }

  void _applyFilters() {
    filteredDoctors = doctorsData.where((user) {
      final specialtyMatch = selectedSpecialty == 'All' ||
          (user['speciality'] != null &&
              user['speciality']
                  .toString()
                  .toLowerCase()
                  .contains(selectedSpecialty.toLowerCase()));

      final nameMatch = nameFilter.isEmpty ||
          (user['username'] != null &&
              user['username']
                  .toString()
                  .toLowerCase()
                  .contains(nameFilter.toLowerCase()));

      final governmentMatch = selectedGovernment == 'All' ||
          (user['location'] != null &&
              user['location']
                  .toString()
                  .toLowerCase()
                  .contains(selectedGovernment.toLowerCase()));

      final experienceMatch = _checkExperience(user);

      return user['isDoctor'] == true &&
          specialtyMatch &&
          nameMatch &&
          governmentMatch &&
          experienceMatch;
    }).toList();
  }

  bool _checkExperience(Map<String, dynamic> user) {
    if (selectedExperienceFilter == 'All') {
      return true;
    } else {
      int userExperience = user['experience'] ?? 0;

      if (selectedExperienceFilter == 'Under 5 years') {
        return userExperience < 5;
      } else if (selectedExperienceFilter == 'Under 10 years') {
        return userExperience < 10;
      } else if (selectedExperienceFilter == 'Under 15 years') {
        return userExperience < 15;
      } else {
        return userExperience >= 15;
      }
    }
  }

  bool _sortAscending = true;

  void _sortDoctorsByConsultationPrice() {
    setState(() {
      _sortAscending = !_sortAscending;

      filteredDoctors.sort(
        (a, b) {
          final aPrice = a['consultationPrice'] ?? 0;
          final bPrice = b['consultationPrice'] ?? 0;

          return _sortAscending
              ? aPrice.compareTo(bPrice)
              : bPrice.compareTo(aPrice);
        },
      );
    });
  }

  void _resetFilters() {
    setState(() {
      selectedSpecialty = 'All';
      selectedGovernment = 'All';
      selectedExperienceFilter = 'All';
      nameFilter = '';
      _sortAscending = true;
      _searchController.clear();
      _applyFilters();
    });
  }

  bool get userLoggedIn => FirebaseAuth.instance.currentUser != null;

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
                controller: _searchController,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Filter and Display Options",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton(
                      onPressed: () {
                        _sortDoctorsByConsultationPrice();
                      },
                      label:
                          'Sort by Consultation Price:${!_sortAscending ? 'High to Low' : 'Low to High'}',
                    ),
                    SizedBox(width: 16.0),
                    _buildButton(
                      onPressed: () {
                        _showGovernmentSelectionPopup(context);
                      },
                      label: 'Selected Government: ${selectedGovernment}',
                    ),
                    SizedBox(width: 16.0),
                    _buildButton(
                      onPressed: () {
                        _showExperienceFilterPopup(context);
                      },
                      label:
                          'Filter by Experience: ${selectedExperienceFilter}',
                    ),
                    SizedBox(width: 16.0),
                    _buildButton(
                      onPressed: () {
                        _resetFilters();
                      },
                      label: 'Reset Filters',
                    ),
                  ],
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

  void _showGovernmentSelectionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Government'),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: governments.map((gov) {
                  return ListTile(
                    title: Text(gov),
                    onTap: () {
                      Navigator.pop(context);
                      _filterDoctorsByGovernment(gov);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showExperienceFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Experience Filter'),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: experienceFilters.map((experience) {
                  return ListTile(
                    title: Text(experience),
                    onTap: () {
                      Navigator.pop(context);
                      _filterDoctorsByExperience(experience);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF4163CD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
