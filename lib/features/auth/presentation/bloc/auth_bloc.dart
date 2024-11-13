import 'package:bloc/bloc.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:deep_lab/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:deep_lab/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUserUsecase _createUserUsecase;
  final GetAllUsersUsecase _getAllUsersUsecase;
  AuthBloc(
      {required CreateUserUsecase createUserUsecase,
      required GetAllUsersUsecase getAllUsersUsecase})
      : _createUserUsecase = createUserUsecase,
        _getAllUsersUsecase = getAllUsersUsecase,
        super(AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetAllUsersEvent>(_getAllUsers);
  }

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _createUserUsecase(CreateUserParam(
        name: event.name, avatar: event.avatar, createdAt: event.createdAt));

    result.fold(
        (failure) => emit(AuthErrorState(
            errorMessage: failure.message, statusCode: failure.statusCode)),
        (_) => emit(const UserCreatedState()));
  }

  Future<void> _getAllUsers(
    GetAllUsersEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GettingAllUsersState());
    final result = await _getAllUsersUsecase();
    result.fold(
        (failure) => emit(AuthErrorState(
            errorMessage: failure.message, statusCode: failure.statusCode)),
        (users) => emit(UsersLoadedState(users: users)));
  }
}
