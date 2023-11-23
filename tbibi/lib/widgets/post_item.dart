import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tbibi/models/post.dart';
import 'package:tbibi/static_data/users_list.dart';

class PostBody extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;
  const PostBody({
    super.key,
    required this.post,
    required this.toggleTheme,
    required this.isDarkMode,
  });
  final Map<String, dynamic> post;

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    loadUserPost();
  }

  Future<void> loadUserPost() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String userId = widget.post['userId'];
      String userDocumentPath = 'users/$userId';

      DocumentSnapshot snapshot = await firestore.doc(userDocumentPath).get();

      if (snapshot.exists) {
        userData = snapshot.data() as Map<String, dynamic>;
        setState(() {});
      }
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  void inSelect(BuildContext context) {
  Navigator.of(context).pushNamed(
    '/post-detail',
    arguments: {
      'post': widget.post,
      'userData': userData,
    },
  ).then((value) {
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
          color: widget.isDarkMode ? Colors.black : Colors.white,
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
                    image: NetworkImage(widget.post['image']),
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
                      widget.post['title'],
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(userData['image']).image,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(userData['username']),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Color(0xFF4163CD),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                          '${DateTime.parse(widget.post['dateTime']).year}-${DateTime.parse(widget.post['dateTime']).month.toString().padLeft(2, '0')}-${DateTime.parse(widget.post['dateTime']).day.toString().padLeft(2, '0')}'),
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
