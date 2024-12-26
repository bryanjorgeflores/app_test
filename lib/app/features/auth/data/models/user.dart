import 'package:app_test/app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.token,
    super.email,
    super.id,
    super.password,
  });

  @override
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      email: json['email'],
      id: json['id'],
      password: json['password'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'id': id,
      'password': password,
    };
  }
}
