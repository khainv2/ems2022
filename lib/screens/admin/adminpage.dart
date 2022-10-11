

import 'package:admin/api/user.dart';
import 'package:admin/api/userrepo.dart';
import 'package:admin/controllers/usercontrol.dart';
import 'package:admin/models/userinfo.dart';
import 'package:admin/models/userpermission.dart';
import 'package:admin/screens/admin/userinfoeditorform.dart';
import 'package:admin/screens/admin/userinfoitem.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final UserRepository repository = UserRepository();
  List<UserInfo> _listUsers = []; 
  UserInfo? _userInfo;

  void getAllUser() async {
    print("get all user");
    getUserList(0, 100).then((value){
      setState(() {
        _listUsers = value.userlist;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    final userControl = UserControl();
    userControl.addStackIndexChangeListener((index){
      if (index == settingIndex){
        getAllUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          constraints: BoxConstraints(maxWidth: 700, maxHeight: double.maxFinite),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getAppBarUI(), 
              SizedBox(height: 6),
              _getUserCount(),
              SizedBox(height: 6),
              _listUsers != null 
              ? _getUserList()
              : CircularProgressIndicator()
            ],
          ),
        )
      ),
    );
  }
 
  Widget _getAppBarUI() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Quản lý tài khoản',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.add,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return UserInfoEditorForm(
                          initUserInfo: _userInfo,
                          onChange: (){
                            getAllUser();
                          },
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getUserCount(){
    return Container(
      padding: EdgeInsets.only(left:20, right: 16),
      child:Text(
        _listUsers == null ? "Đang lấy dữ liệu":
        "Số user đang quản lý: ${_listUsers.length}",
        style: TextStyle(
          color: Colors.blue
        ),
      )
    );
  }
  Widget _getUserList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _listUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return _userItem(context, index);
        }
      )

    );
  }

  Widget _userItem(BuildContext context, int index){
    return ListTile(
      title: UserInfoItem(
        _listUsers[index],
        (){ // On edit
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return UserInfoEditorForm(
                initUserInfo: _listUsers[index],
                onChange: (){
                  getAllUser();
                },
              );
              
            }),
          );
        },
        (){ // On delete 
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Xóa tài khoản?"),
                actions: [
                  FlatButton(
                    child: Text("Xóa"),
                    onPressed: (){
                      var username = _listUsers[index].username;
                      setState(() {
                        _listUsers.removeAt(index);
                      });

                      removeUser(username);

                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },  
                  ),
                  FlatButton(
                    child: Text("Hủy"), 
                    onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  )
                ],
              );
            }
          );
        }
      )
    );
  }
}


