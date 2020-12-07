class LoginModel {
  String userName;
  String password;
  LoginModel({this.userName, this.password});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['userName'] = userName;
    map['password'] = password;
    return map;
  }
}
