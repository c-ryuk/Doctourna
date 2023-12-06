import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tbibi/views/posts/editPost_page.dart';

class PostDetail extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostDetail({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userD = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          userD = snapshot.data() as Map<String, dynamic>;
          setState(() {});
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

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
              backgroundColor:
                  widget.isDarkMode ? Colors.black12 : Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF4163CD),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            floatingActionButton: Visibility(
              visible: userData['uid'] == userD['uid'],
              child: FloatingActionButton(
                onPressed: () {
                  _showOptionsDialog(context, post);
                },
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF4163CD),
                child: const Icon(Icons.more_vert),
              ),
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
                        backgroundImage: userData['image'] != null
                            ? NetworkImage(userData['image']) as ImageProvider
                            : AssetImage('assets/Doc_icon.jpg'),
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
                          post['image'] != null
                              ? post['image']
                              : "https://th.bing.com/th/id/OIP.hV6MoBaE8NYeMCugmhd7_QHaEo?rs=1&pid=ImgDetMain",
                          fit: BoxFit.cover,
                        )),
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
                    Navigator.pop(context);
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
                  onPressed: () async {
                    try {
                      String postId = post['postId'];
                      FirebaseFirestore _firestore = FirebaseFirestore.instance;

                      await _firestore.collection('blog').doc(postId).delete();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF4163CD),
                          content: Text(
                            'Post deleting successfully!',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (error) {
                      print('Error deleting post: $error');
                    }
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
