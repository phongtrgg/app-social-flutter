import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tomiru_social_flutter/common/widgets/friends2_widget/group_image.dart';
import 'package:tomiru_social_flutter/common/widgets/global/time_line/time_line.dart';
import 'package:tomiru_social_flutter/features/Feed/Screens/Feed_Shorts.dart';
import 'package:tomiru_social_flutter/features/social_tweet/controller/social_controller.dart';
import 'package:tomiru_social_flutter/features/social_tweet/domain/models/tweet.dart';

class ForYou extends StatefulWidget {
  final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);
  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  List<Author> userData = [];
  bool _isLoading = false;
  int _page = 0;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _initTweets();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadPosts();
      }
    });
  }

  Future<void> _initTweets() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Get.find<SocialController>().getTweets(_page);
      _extractUserData();
    } catch (e) {
      print("Error fetching tweets: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadPosts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    _page++;

    try {
      await Get.find<SocialController>().getTweets(_page);
      _extractUserData();
    } catch (e) {
      print("Error loading more tweets: $e");
    } finally {
      setState(() {
        _isLoading = false; // Đánh dấu hoàn thành tải dữ liệu
      });
    }
  }

  void _extractUserData() {
    final socialController = Get.find<SocialController>();
    userData.clear();

    for (var tweet in socialController.tweets) {
      userData.add(tweet.author);
    }
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _page = 0;
    });
    await _initTweets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.find<SocialController>().clearTweets();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socialController = Get.find<SocialController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: ValueListenableBuilder<int>(
          valueListenable: widget.pageIndexNotifier,
          builder: (context, index, child) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      GroupImageList(),
                    ],
                  ),
                ),
                if (socialController.tweets.isNotEmpty) ...[
                  TimeLine(
                    scrollController: _scrollController,
                    demoData: socialController.tweets,
                    isLoading: _isLoading,
                    userData: userData,
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
              ],
            );
          },
        ),
      ),
    );
  }
}
