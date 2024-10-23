import 'package:flutter/material.dart';
import 'package:tomiru_social_flutter/features/social_group/Widgets/button_group.dart';
import 'package:tomiru_social_flutter/features/social_group/Widgets/header_group.dart';
import 'package:tomiru_social_flutter/features/social_group/Widgets/infor_group.dart';
import 'package:tomiru_social_flutter/features/social_group/Widgets/members_group.dart';
import 'package:tomiru_social_flutter/features/Profile-social/Widgets/comment_item.dart';
import 'package:tomiru_social_flutter/features/Profile-social/Widgets/post_categories.dart';
import 'package:tomiru_social_flutter/features/Profile-social/Widgets/post_item.dart';
import 'package:tomiru_social_flutter/features/Profile-social/Widgets/posting_option.dart';

class GroupScreen extends StatefulWidget {
  final bool isAdmin;
  final int groupId;
  const GroupScreen({super.key, required this.isAdmin, required this.groupId});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  bool isJoined = false;
  void isJoinGroup(bool value) {
    setState(() {
      isJoined = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderGroup(),
            const SizedBox(
              height: 140,
            ),
            ButtonGroup(
              isJoined: isJoined,
              isJoinGroup: isJoinGroup,
              isAdmin: widget.isAdmin,
            ),
            Divider(
              thickness: 6,
              color: Colors.grey[200],
            ),
            if (!isJoined)
              InforGroup(
                isAdmin: widget.isAdmin,
              ),
            if (!isJoined)
              const SizedBox(
                height: 20,
              ),
            if (!isJoined)
              Divider(
                thickness: 6,
                color: Colors.grey[200],
              ),
            if (!isJoined) MembersGroup(isAdmin: widget.isAdmin),
            if (!isJoined)
              Divider(
                thickness: 6,
                color: Colors.grey[200],
              ),
            PostingOptions(),
            Divider(
              thickness: 6,
              color: Colors.grey[200],
            ),
            PostCategories(),
            PostItem(),
            const CommentItem(
              avatarUrl: "assets/images/mark-zuckerberg.jpg",
              userName: "Mark Zuckerberg",
              comment: "Tư vấn căn hộ giúp mình.",
              timeAgo: '5 giờ trước',
            )
          ],
        ),
      ),
    );
  }
}
