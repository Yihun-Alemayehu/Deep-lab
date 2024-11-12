import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/exceptions.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:deep_lab/features/auth/data/repo/auth_repo_impl.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource dataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepoImpl(remoteDataSource: dataSource);
  });

  group('create user', () {
    const createdAt = 'a.createdAt';
    const name = 'a.name';
    const avatar = 'avatar';
    test('should call [RemoteDataSource] and complete successfully', () async {
      // Arrange
      when(
        () => dataSource.createUser(
            avatar: any(named: 'avatar'),
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt')),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      final result = await repoImpl.createUser(
          avatar: avatar, name: name, createdAt: createdAt);

      // Assert
      expect(result, equals(const Right(null)));
      verify(
        () => dataSource.createUser(
            avatar: avatar, name: name, createdAt: createdAt),
      ).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [ServerFailure] when a call to data source is unsuccessfull',
        () async {
      // Arrange
      when(
        () => dataSource.createUser(
            avatar: any(named: 'avatar'),
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt')),
      ).thenThrow(const ServerException(
          message: 'Unknown error has occured', statusCode: 500));

      // Act
      final result = await repoImpl.createUser(
          avatar: avatar, name: name, createdAt: createdAt);

      // Assert
      expect(
          result,
          equals(const Left(ApiFailure(
              message: 'Unknown error has occured', statusCode: 500))));
      verify(() => dataSource.createUser(
          avatar: avatar, name: name, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('getAllUsers', () {
    // final tUser = UserModel.empty();

    test(
        'should class a [RemoteDataSource.getAllUsers] and return the right data',
        () async {
      // Arrange
      when(() => dataSource.getAllUsers()).thenAnswer((_) async => ([]));

      // Act
      final result = await repoImpl.getAllUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<UserEntity>>>());
      verify(() => dataSource.getAllUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [ServerFailure] when a call to data source is unsuccessfull',
        () async {
      // Arrange
      when(() => dataSource.getAllUsers()).thenThrow(const ServerException(
          message: 'Unknown error has occured', statusCode: 500));

      // Act
      final result = await repoImpl.getAllUsers();

      // Assert
      expect(
          result,
          equals(const Left(ApiFailure(
              message: 'Unknown error has occured', statusCode: 500))));
      verify(() => dataSource.getAllUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
