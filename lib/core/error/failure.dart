// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deep_lab/core/error/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  factory ApiFailure.fromException(ServerException exception){
    return ApiFailure(message: exception.message, statusCode: exception.statusCode);
  }
}
