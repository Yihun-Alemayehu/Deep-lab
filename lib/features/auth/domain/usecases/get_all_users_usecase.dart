import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/core/usecase/usecase.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:deep_lab/features/auth/domain/repos/auth_repo.dart';

class GetAllUsersUsecase extends UsecaseWithoutParams<List<UserEntity>>{
  
  final AuthRepo authRepo;
  GetAllUsersUsecase({required this.authRepo});

  @override
  Future<Either<Failure, List<UserEntity>>> call() async{
    return await authRepo.getAllUsers();
  }

}