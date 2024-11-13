import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/exceptions.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:deep_lab/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:deep_lab/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUserUsecase {}

class MockGetAllUsers extends Mock implements GetAllUsersUsecase {}

void main() {
  late CreateUserUsecase createUserUsecase;
  late GetAllUsersUsecase getAllUsersUsecase;
  late AuthCubit cubit;

  final tCreateUserParams = CreateUserParam.empty();

  const tAPIFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    createUserUsecase = MockCreateUser();
    getAllUsersUsecase = MockGetAllUsers();
    cubit = AuthCubit(
        createUserUsecase: createUserUsecase,
        getAllUsersUsecase: getAllUsersUsecase);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('intial state should be [AuthInitial]', () async {
    expect(cubit.state, AuthInitial());
  });

  group('createUser', () {
    blocTest<AuthCubit, AuthState>(
        'should emit [CreatingUser, UserCreated] when successfull',
        build: () {
          when(() => createUserUsecase(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => const [
              CreatingUserState(),
              UserCreatedState(),
            ],
        verify: (_) {
          verify(() => createUserUsecase(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUserUsecase);
        });

    blocTest<AuthCubit, AuthState>(
      'should emit [creatingUser, AuthError] states when unsuccessfull',
      build: () {
        when(() => createUserUsecase(any()))
            .thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avatar),
      expect: () => [
        const CreatingUserState(),
        AuthErrorState(
            errorMessage: tAPIFailure.message,
            statusCode: tAPIFailure.statusCode),
      ],
      verify: (_) {
        verify(() => createUserUsecase(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUserUsecase);
      }
    );
  
  group('getAllUsers', (){
    blocTest<AuthCubit, AuthState>('should emit [GettingAllUsers, UsersLoaded] states when successfull', 
    build: (){
      when(() => getAllUsersUsecase()).thenAnswer((_) async => const Right([]));
      return cubit;
    },
    act: (cubit) => cubit.getAllUsers(),
    expect: () => const[
      GettingAllUsersState(),
      UsersLoadedState(users: []),
    ],
    verify: (_){
      verify(() => getAllUsersUsecase()).called(1);
      verifyNoMoreInteractions(getAllUsersUsecase);
    });

    blocTest('should emit [GettingAllUsers, AuthError] states when unsuccessfull', 
    build: (){
      when(()=> getAllUsersUsecase()).thenAnswer((_) async=> const Left(tAPIFailure));
      return cubit;
    },
    act: (cubit) => cubit.getAllUsers(),
    expect: () => [
      const GettingAllUsersState(),
      AuthErrorState(errorMessage: tAPIFailure.message, statusCode: tAPIFailure.statusCode),
    ],
    verify: (_){
      verify(() => getAllUsersUsecase()).called(1);
      verifyNoMoreInteractions(getAllUsersUsecase);
    }
    );
  });
  });
}
