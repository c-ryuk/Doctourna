import '../models/post.dart';

const List<Post> Posts_data = [
  Post(
    id: 'm1',
    title: 'Nouvelles découvertes médicales',
    description: 'Découvrez les dernières avancées en médecine.',
    imageUrl:
        'https://th.bing.com/th/id/OIP.7xIQmULu3v-0Qxnn4KuHwgHaE8?w=234&h=180&c=7&r=0&o=5&dpr=1.4&pid=1.7', // Remplacez par l'URL de l'image réelle
    dateTime: "19/12/2022",
    isLike: false,
  ),
  Post(
    id: 'm2',
    title: 'Technologies médicales innovantes',
    description: 'Explorez les technologies révolutionnaires en médecine.',
    imageUrl:
        'https://th.bing.com/th/id/OIP.yD7Lt5-feDokn5A5_YbvlgHaE8?w=231&h=180&c=7&r=0&o=5&dpr=1.4&pid=1.7', // Remplacez par l'URL de l'image réelle
    dateTime: "20/01/2023",
    isLike: false,
  ),
  Post(
    id: 'm3',
    title: 'Recherches sur les maladies rares',
    description: 'Les avancées dans la recherche sur les maladies rares.',
    imageUrl:
        'https://th.bing.com/th/id/OIP.iDnK-NmQBlzEglbtWGhcEAHaEK?w=296&h=180&c=7&r=0&o=5&dpr=1.4&pid=1.7', // Remplacez par l'URL de l'image réelle
    dateTime: "25/02/2023",
    isLike: false,
  ),
  Post(
    id: 'm4',
    title: 'Médecine personnalisée',
    description: "L'avenir de la médecine personnalisée.",
    imageUrl:
        'https://th.bing.com/th/id/OIP.hKjPFjE_MAkssPjhxdTa8QHaE8?w=252&h=180&c=7&r=0&o=5&dpr=1.4&pid=1.7', // Remplacez par l'URL de l'image réelle
    dateTime: "15/03/2023",
    isLike: false,
  ),
  // Ajoutez plus de publications sur le développement de la médecine au besoin...
];

List<Post> getPostsByCatId(String catId) {
  List<Post> filteredList = [];
  for (Post post in Posts_data) {
    if (post.id == catId) {
      filteredList.add(post);
    }
  }
  return filteredList;
}
