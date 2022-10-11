import 'package:tuple/tuple.dart';

enum UserPermission {
  Viewer, 
  Operator, 
  Admin
}

List<Tuple2<UserPermission, String>> _permissionText = [
  Tuple2<UserPermission, String>(UserPermission.Viewer, 'Khách'),
  Tuple2<UserPermission, String>(UserPermission.Operator, 'Vận hành viên'),
  Tuple2<UserPermission, String>(UserPermission.Admin, 'Quản trị viên'),
];

String getDisplayPermission(UserPermission p){
  return _permissionText[p.index].item2;
}

