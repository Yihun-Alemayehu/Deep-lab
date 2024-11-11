import 'package:dartz/dartz.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';
import 'package:deep_lab/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late GetAllUsersUsecase usecase;
  late AuthRepo repo;

  setUp(() {
    repo = MockAuthRepo();
    usecase = GetAllUsersUsecase(authRepo: repo);
  });

  final tResponse = [UserEntity.empty()];

  test('should call [authRepo.getAllUsers] and return [List<UserEntity>]',
      () async {
    // Arrange
    when(() => repo.getAllUsers()).thenAnswer((_) async => Right(tResponse));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right<dynamic, List<UserEntity>>(tResponse)));
    verify(() => repo.getAllUsers()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
