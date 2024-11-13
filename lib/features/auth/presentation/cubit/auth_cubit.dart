import 'package:bloc/bloc.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:deep_lab/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:deep_lab/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUserUsecase _createUserUsecase;
  final GetAllUsersUsecase _getAllUsersUsecase;
  AuthCubit(
      {required CreateUserUsecase createUserUsecase,
      required GetAllUsersUsecase getAllUsersUsecase})
      : _createUserUsecase = createUserUsecase,
        _getAllUsersUsecase = getAllUsersUsecase,
        super(AuthInitial());

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    final result = await _createUserUsecase(
        CreateUserParam(name: name, avatar: avatar, createdAt: createdAt));

    result.fold(
        (failure) => emit(AuthErrorState(
            errorMessage: failure.message, statusCode: failure.statusCode)),
        (_) => emit(const UserCreatedState()));
  }

  Future<void> getAllUsers() async {
    emit(const GettingAllUsersState());
    final result = await _getAllUsersUsecase();
    result.fold(
        (failure) => emit(AuthErrorState(
            errorMessage: failure.message, statusCode: failure.statusCode)),
        (users) => emit(UsersLoadedState(users: users)));
  }
}
