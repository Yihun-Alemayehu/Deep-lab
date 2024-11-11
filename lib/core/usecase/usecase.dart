import 'package:dartz/dartz.dart';
import 'package:deep_lab/core/error/failure.dart';

abstract class UsecaseWithParams<Type,Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}