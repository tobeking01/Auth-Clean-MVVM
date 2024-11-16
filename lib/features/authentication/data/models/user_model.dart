import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  /// Converts a [User] entity to a [UserModel].
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    );
  }
}