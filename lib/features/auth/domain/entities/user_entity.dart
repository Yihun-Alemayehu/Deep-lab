import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;
  final String id;

  const UserEntity({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.id,
  });

  factory UserEntity.empty() {
    return const UserEntity(
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar',
      id: '1',
    );
  }

  @override
  List<Object> get props => [createdAt, name, avatar, id];
}
