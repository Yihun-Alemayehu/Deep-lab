// what does the class depend on ?
//  --  AuthRepo
// how can we create a fake version of the dependency ?
//  --  Use MockTail
// how do we control what our dependencies do ?
//  --  Using MockTail's API

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';
import 'package:deep_lab/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late CreateUserUsecase usecase;
  late AuthRepo repo;

  setUp(() {
    repo = MockAuthRepo();
    usecase = CreateUserUsecase(authRepo: repo);
  });

  final params = CreateUserParam.empty();

  test('should call [authRepo.creatUser]', () async {
    // Arrange
    when(
      () => repo.createUser(
        avatar: any(named: 'avatar'),
        name: any(named: 'name'),
        createdAt: any(named: 'createdAt'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.createUser(
        avatar: params.avatar,
        name: params.name,
        createdAt: params.createdAt,
      ),
    ).called(1);

    verifyNoMoreInteractions(repo);
  });
}
