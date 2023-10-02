class Post {
  final String id;

  final String title;

  final String description;

  final String imageUrl;

  final String dateTime;

  final bool isLike;
  final String userId;

  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.dateTime,
    required this.isLike,
    required this.userId,
  });
}
