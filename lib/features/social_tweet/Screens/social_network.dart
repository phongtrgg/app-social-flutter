import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomiru_social_flutter/features/Friends/Screens/Friend_Screen.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Group_Page.dart';
import 'package:tomiru_social_flutter/features/short_video/screens/short_video_page.dart';
import 'package:tomiru_social_flutter/features/social_user/controller/social_user_controller.dart';
import 'package:tomiru_social_flutter/state/home_controller.dart';
import 'package:tomiru_social_flutter/common/widgets/bottom_menu_bar/bottom_menu_bar.dart';
// import 'package:tomiru_social_flutter/features/Feed/Screens/Feed_Screen.dart';
import 'package:tomiru_social_flutter/features/Home/Screens/Social_page.dart';
import 'package:tomiru_social_flutter/features/discovery/screens/discovery_page.dart';

class SocialNetwork extends StatefulWidget {
  final int initialPageIndex;
  const SocialNetwork({super.key, this.initialPageIndex = 0});
  @override
  State<SocialNetwork> createState() => _SocialNetworkState();
}

class _SocialNetworkState extends State<SocialNetwork> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    // Get.find<HomeController>().setPageIndex(widget.initialPageIndex);
    Get.find<SocialUserController>().getUserByToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().setPageIndex(widget.initialPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _body(),
      bottomNavigationBar: const BottomMenubar(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Obx(() {
        final pageIndex = Get.find<HomeController>().pageIndex.value;

        return getPage(pageIndex);
      }),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return SocialNetworkPage();
      case 1:
        return ShortVideoPage(
          scaffoldKey: _scaffoldKey,
        );
      case 2:
        return const DiscoveryPage();
      case 3:
        return const Friend2Screen();
      case 4:
        return const GroupPage();
      default:
        return SocialNetworkPage();
    }
  }
}
