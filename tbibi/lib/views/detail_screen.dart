import 'package:flutter/material.dart';
import 'package:tbibi/models/post.dart';
import 'package:tbibi/models/user.dart'; // Import the User model
import 'package:tbibi/static_data/users_list.dart';

class PostDetail extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostDetail(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Post;

    User? u = getUserById(argument.userId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black12 : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF4163CD),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: Text(
                argument.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (u != null) // Check if the user is not null
              Row(
                children: [
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundImage: Image.asset(u.imageUrl).image,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${u.fullName}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        u.specialty,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4163CD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 10),
            Hero(
              tag:
                  'post_image_${argument.id}', // Unique tag for the hero animation
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Image.network(
                  argument.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Date_Creation : ${argument.dateTime}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.calendar_month, color: Color(0xFF4163CD)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description :",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            argument.description,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
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
