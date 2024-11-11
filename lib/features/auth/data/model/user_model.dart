import 'dart:convert';

import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.createdAt,
    required super.name,
    required super.avatar,
    required super.id,
  });

  factory UserModel.empty() {
    return const UserModel(
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar',
      id: '1',
    );
  }

  UserModel copyWith({
    String? createdAt,
    String? name,
    String? avatar,
    String? id,
  }) {
    return UserModel(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
