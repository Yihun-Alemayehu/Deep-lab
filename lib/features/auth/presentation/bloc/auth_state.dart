part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class CreatingUserState extends AuthState {
  const CreatingUserState();
}

class GettingAllUsersState extends AuthState{
  const GettingAllUsersState();
}

class UserCreatedState extends AuthState {
  const UserCreatedState();
}

class UsersLoadedState extends AuthState {
  final List<UserEntity> users;

  const UsersLoadedState({required this.users});

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthErrorState extends AuthState {
  final String errorMessage;
  final int statusCode;

  const AuthErrorState({required this.errorMessage, required this.statusCode});

  @override
  List<String> get props => [errorMessage, statusCode.toString()];
}

