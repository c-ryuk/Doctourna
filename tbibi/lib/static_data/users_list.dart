import 'package:tbibi/models/user.dart';

List<User> Users_data = [
  User(
    id: 'u1',
    name: 'Dr. Med MISSA',
    surname: 'Missa',
    specialty: 'Dentiste',
    imageUrl: 'assets/missa.jpg',
  ),
  User(
    id: 'u2',
    name: 'Dr. Hamed TRIKI',
    surname: 'Triki',
    specialty: 'Généraliste',
    imageUrl: 'assets/hamed.jpg',
  ),
  User(
    id: 'u3',
    name: 'Dr. Hamza REKIK',
    surname: 'rkik',
    specialty: 'Cardiologue',
    imageUrl: 'assets/hamza.png',
  ),
];

User? getUserById(String id) {
  for (User user in Users_data) {
    if (user.id == id) {
      return user;
    }
  }
  return null;
}
