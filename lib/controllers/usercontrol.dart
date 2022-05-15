class UserControl {
  
  static final UserControl _singleton = UserControl._internal();
  factory UserControl(){
    return _singleton;
  }
  UserControl._internal();

  String username = '';
  String name = 'Admin';
  String role = '';
  String token = '';

  int currentStackIndex = 0;
  List<Function(int)> currentStackIndexChangeCallbacks = [];

  void addStackIndexChangeListener(Function(int) callback){
    currentStackIndexChangeCallbacks.add(callback);
  }

  void removeStackIndexChangeListener(Function(int) callback){
    currentStackIndexChangeCallbacks.remove(callback);
  }

  void setCurrentStackIndex(int index){
    if (index != currentStackIndex){
      currentStackIndex = index;
      for (final callback in currentStackIndexChangeCallbacks){
        callback(index);
      }
    }
  }
}