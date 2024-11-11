// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/core/usecase/usecase.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';

class CreateUserUsecase extends UsecaseWithParams<void, CreateUserParam> {
  final AuthRepo authRepo;
  CreateUserUsecase({required this.authRepo});
  @override
  Future<Either<Failure, void>> call(CreateUserParam params) async {
    return await authRepo.createUser(
      avatar: params.avatar,
      name: params.name,
      createdAt: params.createdAt,
    );
  }
}

class CreateUserParam extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParam({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory CreateUserParam.empty() {
    return const CreateUserParam(
      avatar: '_empty.avatar',
      createdAt: '_empty.createdAt',
      name: '_empty.name',
    );
  }

  @override
  List<Object> get props => [name, avatar, createdAt];
}
