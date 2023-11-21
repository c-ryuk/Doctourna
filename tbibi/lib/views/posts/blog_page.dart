import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tbibi/static_data/posts_list.dart';
import 'package:tbibi/widgets/post_item.dart';

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
    return Scaffold(
      body: LiquidPullToRefresh(
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
                itemCount: Posts_data.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: PostBody(
                              post: Posts_data[index],
                              toggleTheme: widget.toggleTheme,
                              isDarkMode: widget.isDarkMode),
                        ),
                      ));
                })),
      ),
    );
  }
}
