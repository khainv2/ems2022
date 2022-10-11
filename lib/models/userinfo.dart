import 'package:admin/models/userpermission.dart';

/// User info show in Adminitrator form
class UserInfo {
  String username = '';

  String displayName = '';

  UserPermission userPermission = UserPermission.Viewer;

  String password = '';
  String phone = '';
  String email = '';
  bool active = false;
  String id = '';

  UserInfo(String u, String d, UserPermission p){
    username = u;
    displayName = d;
    userPermission = p;
  }

  static List<UserInfo> testList = [
    UserInfo(
      "username_1", 
      "123456",
      UserPermission.Admin,
    ),
    UserInfo(
      "username_2", 
      "123456",
      UserPermission.Operator,
    ),
    UserInfo(
      "username_3", 
      "123456",
      UserPermission.Operator,
    ),
    UserInfo(
      "username_4", 
      "123456",
      UserPermission.Viewer,
    ),
    
  ];
}