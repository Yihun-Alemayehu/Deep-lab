import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<Either<Failure, void>> createUser({
    required String avatar,
    required String name,
    required String createdAt,
  });

  Future<Either<Failure,UserEntity>> getUserById({required String id});

  Future<Either<Failure,List<UserEntity>>> getAllUsers();

}
