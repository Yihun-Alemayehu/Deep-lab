import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/exceptions.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepoImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> createUser(
      {required String avatar,
      required String name,
      required String createdAt}) async {
    try {
      await _remoteDataSource.createUser(
          avatar: avatar, name: name, createdAt: createdAt);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await _remoteDataSource.getAllUsers();
      return Right(users);
    } on ServerException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
