import 'package:flutter/material.dart';
import 'package:tbibi/static_data/app_data.dart';
import '../widgets/post_item.dart';

class PostScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const PostScreen(
      {Key? key, required this.toggleTheme, required this.isDarkMode})
      : super(key: key);
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 1.4,
      ),
      itemCount: Posts_data.length,
      itemBuilder: (context, index) => PostBody(
        post: Posts_data[index],
        toggleTheme: widget.toggleTheme,
        isDarkMode: widget.isDarkMode
      ),
    );
  }
}
