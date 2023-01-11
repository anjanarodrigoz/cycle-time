enum UserStatus {
  driver,
  manager,
  trainee,
  siteEngineer,
}

class UserField {
  static const String id = 'id';
  static const String name = 'name';
  static const String password = 'password';
  static const String status = 'status';
}

class User {
  final String id;
  final String name;
  final String password;
  final UserStatus status;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.status});

  Map<dynamic, dynamic> toJson() => {
        UserField.id: id,
        UserField.name: name,
        UserField.password: password,
        UserField.status: status.name
      };

  User fromJson(json) => User(
      id: json[UserField.id],
      name: UserField.name,
      password: UserField.password,
      status: UserStatus.values.byName(UserField.status));
}
