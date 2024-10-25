import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomiru_social_flutter/features/bussiness/Screens/fund_screen.dart';
import 'package:tomiru_social_flutter/features/bussiness/Screens/income_screen.dart';
import 'package:tomiru_social_flutter/features/bussiness/Screens/membership_package.dart';
import 'package:tomiru_social_flutter/features/bussiness/Screens/net_screen.dart';
import 'package:tomiru_social_flutter/features/bussiness/Screens/package_detail.dart';
import 'package:tomiru_social_flutter/features/bussiness/Widgets/business_appbar.dart';
import 'package:tomiru_social_flutter/features/bussiness/Widgets/business_bottom_navbar.dart';
import 'package:tomiru_social_flutter/features/Feed/Screens/Feed_Screen.dart';
import 'package:tomiru_social_flutter/features/Friends/Screens/Friend_Screen.dart';
import 'package:tomiru_social_flutter/features/bussiness/controllers/business_controller.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Group_Page.dart';
import 'package:tomiru_social_flutter/features/Profile-social/Screens/Profile_Screen.dart';
import 'package:tomiru_social_flutter/state/app_state.dart';
import 'package:tomiru_social_flutter/state/home_controller.dart';
import 'package:tomiru_social_flutter/common/widgets/ui/custom_mainbar.dart';
import 'package:tomiru_social_flutter/common/widgets/custom_icon_widgets.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().setPageIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onBackPress: () => Navigator.of(context).pop(),
        titleText: 'Kinh doanh',
        padding: 0,
        widget: [
          customQr(context),
          customMessage(context),
          customNotification(context),
          const SizedBox(width: 12.0)
        ],
      ),
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            child: _body(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
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
        return const NetScreen();
      case 1:
        return const FundScreen();
      case 2:
        return IncomeScreen();
      case 3:
        return PackageDetail();
      case 4:
        return MembershipPackage();
      default:
        return FeedPage(scaffoldKey: _scaffoldKey);
    }
  }
}
