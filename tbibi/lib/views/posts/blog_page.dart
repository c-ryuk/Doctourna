import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tbibi/views/posts/addPost_page.dart';
import 'package:tbibi/widgets/post_item.dart';

class PostScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const PostScreen({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> posts = [];
  bool _isLoadingUserData = true;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('blog').get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          posts = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          // Set userData and update loading state when data is fetched
          setState(() {
            userData = snapshot.data() as Map<String, dynamic>;
            _isLoadingUserData = false; // Data has been loaded
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingUserData
          ? Center(
              child:
                  CircularProgressIndicator()) // Display circular progress indicator while loading userData
          : LiquidPullToRefresh(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              height: 100,
              animSpeedFactor: 5.0,
              springAnimationDurationInMilliseconds: 700,
              color: Color(0xFF4163CD),
              showChildOpacityTransition: false,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 4));
              },
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: PostBody(
                            post: posts[index],
                            toggleTheme: widget.toggleTheme,
                            isDarkMode: widget.isDarkMode,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: userData['isDoctor'] != false
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPostPage(userData: userData),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
