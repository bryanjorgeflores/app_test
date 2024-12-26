class User {
  final String? email;
  final String? password;
  final int? id;
  final String? token;

  User({
    this.email,
    this.password,
    this.id,
    this.token,
  });

  User copyWith({
    String? email,
    String? password,
    int? id,
    String? token,
  }) =>
      User(
        email: email ?? this.email,
        password: password ?? this.password,
        id: id ?? this.id,
        token: token ?? this.token,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "id": id,
        "token": token,
      };
}
