import 'package:deep_lab/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  
  Future<void> createUser({
    required String avatar,
    required String name,
    required String createdAt,
  });

  // Future<UserEntity> getUserById({required String id});

  Future<List<UserModel>> getAllUsers();
}