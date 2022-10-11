
import 'package:admin/api/user.dart';
import 'package:admin/api/userrepo.dart';
import 'package:admin/models/userinfo.dart';
import 'package:admin/models/userpermission.dart';
import 'package:flutter/material.dart';

class UserInfoEditorForm extends StatefulWidget {
  UserInfoEditorForm(
    {
      required this.initUserInfo,
      required this.onChange
    }
  );

  // Function(UserInfo) userInfoChanged;
  final UserInfo? initUserInfo;
  final Function onChange;

  @override
  _UserInfoEditorFormState createState() => _UserInfoEditorFormState();
}

class _UserInfoEditorFormState extends State<UserInfoEditorForm> {
  // UserInfo _newUserInfo = UserInfo('', '', UserPermission.Viewer);
  final _txtName = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtDisplayName = TextEditingController();
  final _txtPhone = TextEditingController();
  final _txtEmail = TextEditingController();
  var _userPermission = UserPermission.Viewer;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.initUserInfo != null){
      _txtName.text = widget.initUserInfo!.username;
      _txtDisplayName.text = widget.initUserInfo!.displayName;
      _txtPassword.text = widget.initUserInfo!.password;
      _txtPhone.text = widget.initUserInfo!.phone;
      _txtEmail.text = widget.initUserInfo!.email;
      _userPermission = widget.initUserInfo!.userPermission;
    } else {
      _txtEmail.text = 'user@mail.com';
    }

    final c = Container(
      padding: EdgeInsets.all(20),
      
          constraints: BoxConstraints(maxWidth: 700, maxHeight: double.maxFinite),
      child: ListView(
        children: [
          TextField(
            controller: _txtName,
            readOnly: widget.initUserInfo != null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tên tài khoản',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _txtPassword,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mật khẩu',
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('Phân quyền'),
              SizedBox(width: 10),
              DropdownButton<UserPermission>(
              value: _userPermission,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                color: Colors.blue,
              ),
              onChanged: (UserPermission ?newValue) {
                setState(() {
                  _userPermission = newValue ?? UserPermission.Viewer;
                });
              },
              items: [
                DropdownMenuItem<UserPermission>(
                  value: UserPermission.Viewer,
                  child: Text('Khách'),
                ),
                DropdownMenuItem<UserPermission>(
                  value: UserPermission.Operator,
                  child: Text('Điều hành'),
                ),
                DropdownMenuItem<UserPermission>(
                  value: UserPermission.Admin,
                  child: Text('Quản trị'),
                ),
              ]
            ),
            ],
          ),
          

          TextField(
            controller: _txtDisplayName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tên hiển thị',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _txtPhone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Số điện thoại',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _txtEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 999,
            height: 42,
            child: RaisedButton(
              child: Text(
                widget.initUserInfo == null
                ? 'Thêm tài khoản'
                : 'Cập nhật tài khoản',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: (){
                if (_txtName.text.length < 4){
                  final snackBar = SnackBar(content: Text(
                    'Tên đăng nhập phải có ít nhất 4 ký tự'
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                if (_txtPassword.text.length < 8){
                  final snackBar = SnackBar(content: Text(
                    'Mật khẩu phải có ít nhất 8 ký tự'
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                if (_txtDisplayName.text.isEmpty){
                  final snackBar = SnackBar(content: Text(
                    'Tên hiển thị chưa hợp lệ'
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                
                if (_txtEmail.text.isEmpty){
                  final snackBar = SnackBar(content: Text(
                    'Email không hợp lệ'
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                

                if (widget.initUserInfo == null){
                  // Thêm user mới
                  addNewUser(context);
                } else {
                  // Cập nhật user đã có
                  updateCurrentUser(context);
                }

              },
              color: Colors.blue,
            )
          )
        ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.initUserInfo == null
          ? Text('Thêm tài khoản') 
          : Text('Cập nhật tài khoản'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: c
      )
    );
  }


  void addNewUser(BuildContext context) async {
    final userRepo = UserRepository();
    final newUser = UserInfo(
      _txtName.text,
      _txtDisplayName.text,
      _userPermission
    );
    newUser.password = _txtPassword.text;
    newUser.phone = _txtPhone.text;
    newUser.email = _txtEmail.text;
    // if (newUser.password.length < 8){
    //   final snackBar = SnackBar(
    //     content: Text(
    //       'Mật khẩu phải có ít nhất 8 ký tự'
    //     ),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   return;
    // }
    final result = await createUser(newUser);
    if (result){
      final snackBar = SnackBar(content: Text(
        'Đã tạo tài khoản thành công'
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 1), (){
        Navigator.pop(context);
        if (widget.onChange != null){
          widget.onChange();
        }
      });
    } else {
      final snackBar = SnackBar(content: Text(
        'Lỗi'
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void updateCurrentUser(BuildContext context) async {
    final updatedUser = UserInfo(
      _txtName.text,
      _txtDisplayName.text,
      _userPermission
    );
    updatedUser.phone = _txtPhone.text;
    updatedUser.email = _txtEmail.text;
    updatedUser.password = _txtPassword.text;
    final result = await updateUser(updatedUser);
    if (result){
      final snackBar = SnackBar(content: Text(
        'Đã cập nhật tài khoản thành công',
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 1), (){
        Navigator.pop(context);
        if (widget.onChange != null){
          widget.onChange();
        }
      });
    } else {
      final snackBar = SnackBar(content: Text(
        'Lỗi'
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}