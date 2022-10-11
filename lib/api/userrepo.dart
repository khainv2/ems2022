


import 'package:admin/models/userinfo.dart';

class UserRepository {
  Future<List<UserInfo>> getAll() async {
     return [
       
     ];
    // var url = '${hostTest()}/user';
    // final pref = await SharedPreferences.getInstance();
    // var token = pref.getString('token');
    // print('Start to get all user at $url');

    // var response = await http.get(
    //   url,
    //   headers: {
    //     'Authorization': 'Bearer $token'
    //   }
    // );
    
    // print(response.body);
    // List<dynamic> body = jsonDecode(response.body);
    // List<UserInfo> listUsers = body.map((e){
    //   Map<String, dynamic> userNode = e;
    //   UserInfo userInfo;
 
    //   if (userNode.containsKey('username')
    //     && userNode.containsKey('role')
    //     && userNode.containsKey('profile')){
    //     print(userNode['profile']);
    //     Map<String, dynamic> profileNode = userNode['profile'];
    //     if (profileNode.containsKey('fullname')){
    //       String username = userNode['username'];
    //       String roleString = userNode['role'];
    //       String displayName = profileNode['fullname'];
          
    //       // Convert role string to role enums
    //       UserPermission userPermission;
    //       if (roleString == 'Administrator'){
    //         userPermission = UserPermission.Admin;
    //       } else if (roleString == 'Viewer'){
    //         userPermission = UserPermission.Viewer;
    //       } else {
    //         userPermission = UserPermission.Operator;
    //       }
    //       userInfo = UserInfo(username, displayName, userPermission);

    //       if (profileNode.containsKey('phone')){
    //         userInfo.phone = profileNode['phone'];
    //       }

    //       if (profileNode.containsKey('email')){
    //         userInfo.email = profileNode['email'];
    //       }
    //     }
    //   }

    //   return userInfo;
    // }).where((element) => (element != null)).toList();

    // return listUsers;
  }

  Future<bool> createUser(UserInfo userInfo) async {
     return false;
    // var url = '${hostTest()}/user';
    // final pref = await SharedPreferences.getInstance();
    // var token = pref.getString('token');
    // print('Start to create user at $url');

    // String roleStr;
    // if (userInfo.userPermission == UserPermission.Admin){
    //   roleStr = "Administrator";
    // } else if (userInfo.userPermission == UserPermission.Operator){
    //   roleStr = "Operator";
    // } else {
    //   roleStr = "Viewer";
    // }
    // var response = await http.post(
    //   url,
    //   headers: {
    //     'Authorization': 'Bearer $token'
    //   },
    //   body: {
    //     'username': userInfo.username,
    //     'role': roleStr,
    //     'password': userInfo.password,
    //     'fullname': userInfo.displayName,
    //     'phone': userInfo.phone,
    //     'email': userInfo.email
    //   }
    // );
    // print('Status code ${response.statusCode}');
    // print('Body ${response.body}');
    // return response.statusCode == 200;
  }

  Future<bool> updateUser(UserInfo userInfo) async {
    return false;
    // var url = '${hostTest()}/user/${userInfo.username}';
    // final pref = await SharedPreferences.getInstance();
    // var token = pref.getString('token');
    // print('Start to update user at $url');

    // String roleStr;
    // if (userInfo.userPermission == UserPermission.Admin){
    //   roleStr = "Administrator";
    // } else if (userInfo.userPermission == UserPermission.Operator){
    //   roleStr = "Operator";
    // } else {
    //   roleStr = "Viewer";
    // }
    // var response = await http.put(
    //   url,
    //   headers: {
    //     'Authorization': 'Bearer $token'
    //   },
    //   body: {
    //     'username': userInfo.username,
    //     'role': roleStr,
    //     'password': userInfo.password,
    //     'fullname': userInfo.displayName,
    //     'phone': userInfo.phone,
    //     'email': userInfo.email
    //   }
    // );
    // print(response.statusCode);
    // print(response.body);
    // return response.statusCode == 200;
  }

  Future<bool> removeUser(String username) async {
     return false;
    // var url = '${hostTest()}/user/$username';
    // final pref = await SharedPreferences.getInstance();
    // var token = pref.getString('token');
    // print('Start to get all user at $url');

    // var response = await http.delete(
    //   url,
    //   headers: {
    //     'Authorization': 'Bearer $token'
    //   },
    // );

    // print(response.statusCode);
    // print(response.body);
    // return response.statusCode == 200;
  }
}  