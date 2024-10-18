import '../entities/user_entity.dart';

class UserModel {
  String? name;
  String? email;

  UserModel({this.name, this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      name: name,
    );
  }
}
