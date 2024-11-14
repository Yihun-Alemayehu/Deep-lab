import 'package:deep_lab/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:deep_lab/features/auth/data/repo/auth_repo_impl.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';
import 'package:deep_lab/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:deep_lab/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:deep_lab/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {

  sl
//   App Logic
    ..registerFactory(
        () => AuthCubit(createUserUsecase: sl(), getAllUsersUsecase: sl()))

// Usecases
    ..registerLazySingleton(() => CreateUserUsecase(authRepo: sl()))
    ..registerLazySingleton(() => GetAllUsersUsecase(authRepo: sl()))

// Repositories
    ..registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(remoteDataSource: sl()))

// Data Sources
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()))

// External dependencies
    ..registerLazySingleton(() => http.Client());
}
