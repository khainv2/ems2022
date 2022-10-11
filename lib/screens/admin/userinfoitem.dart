import 'package:admin/common.dart';
import 'package:admin/models/userinfo.dart';
import 'package:admin/models/userpermission.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class UserInfoItem extends StatefulWidget {
  final UserInfo _userInfo;

  UserInfoItem(this._userInfo, this.onEdit, this.onDelete);

  Function onEdit;
  Function onDelete;

  @override
  _UserInfoItemState createState() => _UserInfoItemState();
}

class _UserInfoItemState extends State<UserInfoItem> {

  static List<Tuple2<UserPermission, String>> _permissionText = [
    Tuple2<UserPermission, String>(UserPermission.Admin, 'Quản trị viên'),
    Tuple2<UserPermission, String>(UserPermission.Operator, 'Vận hành viên'),
    Tuple2<UserPermission, String>(UserPermission.Viewer, 'Khách')
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      elevation: 5.0,
      child: new Container(
        margin: new EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
        child: Row (
          children: [
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget._userInfo.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                    ),
                    SizedBox(height: 6,),
                    Text(
                      widget._userInfo.displayName,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          widget._userInfo.phone,
                        ),
                        SizedBox(width: 12),
                        Text(
                          widget._userInfo.email,
                        ),
                      ],
                    )
                  ],
                )
              )
            ),
            Text(_permissionText.where(
                (v) => v.item1 == widget._userInfo.userPermission
              ).first.item2,
              style: TextStyle(
                color: Colors.blue
              ),
            ),
            
            PopupMenuButton(
              elevation: 3.2,
              onSelected: (value){
                if (value == "edit"){
                  widget.onEdit();
                } else if (value == "delete"){
                  widget.onDelete();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: "edit",
                    child: Text("Cập nhật thông tin"),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text("Xóa"),
                  ),
                ]; 
              },
            )
          ],
        )
      ),
    );
  }
}