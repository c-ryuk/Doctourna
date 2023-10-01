import 'package:flutter/material.dart';
import 'package:tbibi/models/post.dart';

class PostDetail extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostDetail(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Post;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.green : Colors.lightGreen,
        title: Text(
          argument.title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
          maxLines:
              null, // Allow the text to wrap to the next line if necessary
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: 1.0, // Make the image take full width
              child: Image.network(
                argument.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "Date_Creation : ",
                    style: TextStyle(
                      color: isDarkMode ? Colors.green : Colors.lightGreen,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    argument.dateTime,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Discription :",
                style: TextStyle(
                  color: isDarkMode ? Colors.green : Colors.lightGreen,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                argument.description,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
