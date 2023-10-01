import 'package:flutter/material.dart';
import 'package:tbibi/models/post.dart';

class PostBody extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostBody({
    super.key,
    required this.post,
    required this.toggleTheme,
    required this.isDarkMode,
  });
  final Post post;

  void inSelect(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      '/post-detail',
      arguments: post,
    )
        .then((value) {
      if (value != null) {
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => inSelect(context),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 25,
              color: Colors.black26,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(post.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("missa"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.today,
                        color: Colors.lightGreen,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(post.dateTime),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
