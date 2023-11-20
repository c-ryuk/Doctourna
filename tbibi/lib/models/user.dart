class User {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String specialty;
  final String imageUrl;
  final bool isDoctor;
  final int? rating;
  final int phone;
  final String? facebook;
  final String adress;
  final String gouvernment;
  final int? experience;
  final int? patient;
  final String? aboutMe;
  final int consultationPrice;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.specialty,
    required this.imageUrl,
    required this.isDoctor,
    this.rating,
    required this.phone,
    this.facebook,
    required this.adress,
    required this.gouvernment,
    this.experience,
    this.patient,
    this.aboutMe,
    required this.consultationPrice,
  });
}
