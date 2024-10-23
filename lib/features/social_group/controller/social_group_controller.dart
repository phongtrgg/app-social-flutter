import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tomiru_social_flutter/common/widgets_2/custom_snackbar_widget.dart';
import 'package:tomiru_social_flutter/features/social_group/domain/models/group.dart';
import 'package:tomiru_social_flutter/features/social_group/domain/models/group_request.dart';
import 'package:tomiru_social_flutter/features/social_group/domain/service/social_group_service_interface.dart';
import 'package:tomiru_social_flutter/helper/route_helper.dart';

class SocialGroupController extends GetxController implements GetxService {
  final SocialGroupServiceInterface socialGroupServiceInterface;

  SocialGroupController({required this.socialGroupServiceInterface});

  List<GroupModel> _userGroup = [];
  List<GroupModel> get userGroup => _userGroup;

  List<GroupModel> _userGroupOwner = [];
  List<GroupModel> get userGroupOwner => _userGroupOwner;

  List<GroupModel> _suggestGroup = [];
  List<GroupModel> get suggestGroup => _suggestGroup;

  //create group
  bool _isPrivate = false;
  bool get isPrivate => _isPrivate;
  late String _groupName;
  String get groupName => _groupName;
  late String _description;
  String get description => _description;

  void setPrivate(bool value) {
    _isPrivate = value;
  }

  void setGroupName(String name) {
    _groupName = name;
  }

  void setDescription(String text) {
    _description = text;
  }

  void createGroup() async {
    GroupRequest group = GroupRequest(
        description: _description,
        groupName: _groupName,
        isPrivate: _isPrivate);
    try {
      await socialGroupServiceInterface.createGroup(group);
      showCustomSnackBar('Nhóm đã được tạo thành công!',
          showToaster: true, isError: false);
      Get.toNamed(RouteHelper.getSocicalNetworkRoute('4'));
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }
  //end create group

  void getGroupById(int id) async {
    try {
      await socialGroupServiceInterface.getGroupById(id);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
    update();
  }

  void editGroup(GroupModel request) async {
    try {
      await socialGroupServiceInterface.editGroup(request);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void deleteGroup(int id) async {
    try {
      await socialGroupServiceInterface.deleteGroup(id);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void requestJoinGroup(int id) async {
    try {
      await socialGroupServiceInterface.deleteGroup(id);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void acceptJoinGroup(AcceptUserToGroupRequest request) async {
    try {
      await socialGroupServiceInterface.acceptJoinGroup(request);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void removeMemberGroup(int groupId, int memberId) async {
    try {
      await socialGroupServiceInterface.removeMemberGroup(groupId, memberId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void blockUserGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.blockUserGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void unblockUserGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.unblockUserGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void rejectGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.rejectGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void assignGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.assignGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void demotedGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.demotedGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void transferRightsGroup(int groupId, int userId) async {
    try {
      await socialGroupServiceInterface.demotedGroup(groupId, userId);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void getSuggestGroup(int page) async {
    try {
      _suggestGroup = await socialGroupServiceInterface.suggestGroup(page);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void clearSuggestGroup() {
    _suggestGroup.clear();
  }

  void getGroupByUserId(int userId, int page) async {
    _userGroup.clear();
    _userGroupOwner.clear();
    try {
      List<GroupModel> groups =
          await socialGroupServiceInterface.getGroupByUserId(userId, page);
      // _userGroup.addAll(groups);

      for (var group in groups) {
        if (group.groupOwner?.id! == userId) {
          _userGroupOwner.add(group);
        } else {
          _userGroup.add(group);
        }
      }
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
    update();
  }

  void clearUserGroup() {
    _userGroup.clear();
    _userGroupOwner.clear();
  }

  void getMemberGroup(int groupId, int page) async {
    try {
      await socialGroupServiceInterface.getMemberGroup(groupId, page);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void getPendingMemberGroup(int groupId, int page) async {
    try {
      await socialGroupServiceInterface.getPendingMemberGroup(groupId, page);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void getBlockedUserGroup(int groupId, int page) async {
    try {
      await socialGroupServiceInterface.getBlockedUserGroup(groupId, page);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }

  void searchGroupByUserName(String groupName, int page) async {
    try {
      await socialGroupServiceInterface.searchGroupByUserName(groupName, page);
    } catch (e) {
      showCustomSnackBar(
          e.toString().replaceAll('Exception', '').replaceAll(':', ''),
          showToaster: true);
    }
  }
}
