class User {
  final int id;
  final String usr;
  final String pwd;
  final String level;
  final int isActive;
  final String updated;
  final String? lastLogin;
  final String? loginFrom;

  User({
    required this.id,
    required this.usr,
    required this.pwd,
    required this.level,
    required this.isActive,
    required this.updated,
    this.lastLogin,
    this.loginFrom,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      usr: json['usr'],
      pwd: json['pwd'],
      level: json['level'],
      isActive: json['isActive'],
      updated: json['updated'],
      lastLogin: json['last_login'],
      loginFrom: json['login_from'],
    );
  }
}