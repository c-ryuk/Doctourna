import 'package:flutter/material.dart';
import 'package:tbibi/views/posts/editPost_page.dart';

class PostDetail extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostDetail({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Map<String, dynamic> post = argument['post'];
    Future<Map<String, dynamic>> userDataFuture = argument['userData'];

    return FutureBuilder<Map<String, dynamic>>(
      future: userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Failed to load data'),
            ),
          );
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: isDarkMode ? Colors.black12 : Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF4163CD),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showOptionsDialog(context, post);
              },
              child: const Icon(Icons.more_vert),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 30,
                    ),
                    child: Text(
                      post['title'],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData['image']),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData['username']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData['speciality'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4163CD),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Hero(
                    tag: 'post_image_${post['title']}',
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Image.network(
                        post['image'],
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
                                  "Date_Creation : ${DateTime.parse(post['dateTime']).year}-${DateTime.parse(post['dateTime']).month.toString().padLeft(2, '0')}-${DateTime.parse(post['dateTime']).day.toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.calendar_month,
                                    color: Color(0xFF4163CD)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Description :",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  post['description'],
                                  style: const TextStyle(
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
      },
    );
  }

  void _showOptionsDialog(BuildContext context, Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Post Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditPostPage(post: post),
                      ),
                    );
                  },
                  child: const Text('Edit Post'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for deleting the post here
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Delete Post'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
