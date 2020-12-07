class User {
  String email;
  String name;
  String bornDate;
  String sex;
  String password;
  User({this.email, this.name, this.bornDate, this.sex, this.password});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['email'] = email;
    map['name'] = name;
    map['bornDate'] = bornDate;
    map['sex'] = sex;
    map['password'] = password;
    return map;
  }

  User.fromObject(dynamic obj) {
    this.email = obj['email'];
    this.name = obj['name'];
    this.bornDate = obj['bornDate'];
    this.sex = obj['sex'];
    this.password = obj['password'];
  }
}
