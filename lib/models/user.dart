import '../entities/user_entity.dart';

class UserModel {
  String? name;
  String? email;
  String? uid;

  UserModel({this.name, this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
    uid = data['uid'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      name: name,
      uid: uid,
    );
  }
}
