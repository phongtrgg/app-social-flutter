import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Manage_Event.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Manage_Group.dart';
import 'package:tomiru_social_flutter/features/social_group/controller/social_group_controller.dart';
import 'package:tomiru_social_flutter/features/social_user/controller/social_user_controller.dart';
import 'Group_Bar.dart';
import 'ForYou.dart';
import "My_Group.dart";

class GroupPage extends StatefulWidget {
  final bool showEventExist;
  final int initialPageIndex;
  const GroupPage(
      {super.key, this.initialPageIndex = 0, this.showEventExist = false});
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  int _innerPageIndex = 0;
  final bool showEventExist = false; // Thêm tham số showEventExist

  final List<Widget> _innerPages = [
    ForYou(),
    MyGroup(),
    ManageGroup(),
    ManageEvent(),
    // EventExist()
    // timeLine(),
    // Add more pages if needed
  ];

  void _navigateTo(int index) {
    setState(() {
      _innerPageIndex = index;
      // _innerPageIndex = widget.initialPageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _innerPageIndex = widget.initialPageIndex;
    Get.find<SocialGroupController>()
        .getGroupByUserId(Get.find<SocialUserController>().user.id!, 0);
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<SocialGroupController>().clearUserGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GroupBar(
            navigateTo: _navigateTo,
            initialPageIndex: _innerPageIndex,
          ),
          Expanded(
            child: IndexedStack(
              index: _innerPageIndex,
              children: _innerPages.map((page) {
                if (page is ManageEvent) {
                  return ManageEvent(showEventExist: widget.showEventExist);
                } else {
                  return page;
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
