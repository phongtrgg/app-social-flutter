import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Group_Screen.dart';
import 'package:tomiru_social_flutter/features/social_group/Screens/Infor_Group_Screen.dart';
import 'package:tomiru_social_flutter/features/social_group/controller/social_group_controller.dart';

class MyGroup extends StatefulWidget {
  @override
  _MyGroupState createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  final paddingTextInTextField = 14.0;

  @override
  void dispose() {
    super.dispose();
    Get.find<SocialGroupController>().clearUserGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<SocialGroupController>(builder: (groupController) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Align right
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Đã ghim ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: '(4)',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle Edit button press
                      },
                      child: const Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue, // Optional: Add blue color
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Recent Group Activities Section
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    // padding: EdgeInsets.all(8.0), // Adjust padding as needed
                    margin: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust margin as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Set background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Add rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      leading: const SizedBox(
                        width: 56,
                        height: 56,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/icon-tomiru-appbar.jpg'),
                        ),
                      ),
                      title: Text('Hội Saler Sun Tower'),
                      subtitle: Text('126 Members - 530 Posts'),
                      trailing: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: IconButton(
                            icon: Image.asset(
                              'assets/images/Pinned.png',
                              width: 30.0,
                              height: 30.0,
                            ),
                            onPressed: () {},
                          )),
                    ),
                  );
                },
              ),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.92, //
                  child: Container(
                    color: Color.fromARGB(255, 243, 241, 241),
                    height: 2.5,
                  ),
                ),
              ),
              groupController.userGroupOwner.length > 1
                  ? Container(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Align right
                        children: [
                          const Text(
                            'Nhóm bạn quản lý',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle Edit button press
                            },
                            child: const Text(
                              'Tạo',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue, // Optional: Add blue color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),

              //Recent Group Activities Section
              ListView.builder(
                shrinkWrap: true,
                itemCount: groupController.userGroupOwner.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupScreen(
                            isAdmin: true,
                            groupId: groupController.userGroup[index].id as int,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: const SizedBox(
                          width: 56,
                          height: 56,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/icon-tomiru-appbar.jpg'),
                          ),
                        ),
                        title: Text(groupController
                            .userGroupOwner[index].groupName
                            .toString()),
                        subtitle: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${groupController.userGroupOwner[index].totalMembers} Members '),
                              // const TextSpan(
                              //     text: '- Cập nhật khoảng 1h trước'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.92, //
                  child: Container(
                    color: Color.fromARGB(255, 243, 241, 241),
                    height: 2.5,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Align right
                  children: [
                    const Text(
                      'Nhóm bạn đã tham gia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.swap_vert,
                          color: Colors.black,
                          size: 30.0,
                        )),
                  ],
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: SizedBox(
                    width: 38,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 128, 126, 126),
                        ),
                        hintText: "Tìm tên",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 128, 126, 126),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: paddingTextInTextField,
                            bottom: paddingTextInTextField),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 245, 244, 244),
                      ),
                    )),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groupController.userGroup.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupScreen(
                            isAdmin: true,
                            groupId: groupController.userGroup[index].id as int,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: const SizedBox(
                          width: 56,
                          height: 56,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/icon-tomiru-appbar.jpg',
                            ),
                          ),
                        ),
                        title: Text(groupController.userGroup[index].groupName
                            .toString()),
                        subtitle: Text(
                            '${groupController.userGroup[index].totalMembers} Members - 530 Posts'),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
