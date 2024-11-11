import 'package:dartz/dartz.dart';
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
      required String createdAt}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }
}
