import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ServerException({required this.message, required this.statusCode,});
  
  @override
  List<Object?> get props => [message, statusCode];
}