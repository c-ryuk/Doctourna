import 'package:tbibi/models/user.dart';

List<User> Users_data = [
  User(
    id: 'u1',
    fullName: 'Dr. Med MISSA',
    email: 'missa@gmail.com',
    password: 'aaaa',
    specialty: 'Dentiste',
    imageUrl: 'assets/missa.jpg',
    isDoctor: true,
    rating: 7,
    phone: 11223344,
    facebook: 'facebook/missa',
    adress: 'somewhere in sfax',
    gouvernment: 'sfax',
    experience: 5,
    patient: 300,
    aboutMe:
        "I'm a dedicated healthcare professional committed to providing compassionate care and improving the well-being of my patients.With years of experience, I strive to offer expertise in diagnosing and treating various medical conditions while promoting a healthy lifestyle.",
    consultationPrice: 30,
  ),
  User(
    id: 'u2',
    fullName: 'Dr. Hamed TRIKI',
    email: 'hamed@gmail.com',
    password: 'bbbb',
    specialty: 'Généraliste',
    imageUrl: 'assets/hamed.jpg',
    isDoctor: true,
    rating: 6,
    phone: 11223344,
    facebook: 'facebook/hamed',
    adress: 'somewhere in sfax',
    gouvernment: 'sfax',
    experience: 12,
    patient: 1520,
    aboutMe:
        "I'm a dedicated healthcare professional committed to providing compassionate care and improving the well-being of my patients.With years of experience, I strive to offer expertise in diagnosing and treating various medical conditions while promoting a healthy lifestyle.",
    consultationPrice: 60,
  ),
  User(
    id: 'u3',
    fullName: 'Dr. Hamza REKIK',
    email: 'hamza@gmail.com',
    password: 'cccc',
    specialty: 'Cardiologue',
    imageUrl: 'assets/hamza.png',
    isDoctor: false,
    rating: 9,
    phone: 11223344,
    facebook: 'facebook/hamza',
    adress: 'somewhere in sfax',
    gouvernment: 'sfax',
    experience: 7,
    patient: 700,
    aboutMe:
        "I'm a dedicated healthcare professional committed to providing compassionate care and improving the well-being of my patients.With years of experience, I strive to offer expertise in diagnosing and treating various medical conditions while promoting a healthy lifestyle.",
    consultationPrice: 45,
  ),
];

User getUserById(String id) {
  for (User user in Users_data) {
    if (user.id == id) {
      return user;
    }
  }

  return User(
      id: '',
      fullName: '',
      email: '',
      password: '',
      specialty: '',
      imageUrl: '',
      isDoctor: true,
      rating: 0,
      phone: 0,
      facebook: '',
      adress: '',
      gouvernment: '',
      experience: 0,
      patient: 0,
      aboutMe: '',
      consultationPrice: 0);
}
