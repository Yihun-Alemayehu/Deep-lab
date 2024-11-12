import 'package:deep_lab/core/error/exceptions.dart';
import 'package:deep_lab/core/utils/constants.dart';
import 'package:deep_lab/features/auth/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String avatar,
    required String name,
    required String createdAt,
  });

  // Future<UserEntity> getUserById({required String id});

  Future<List<UserModel>> getAllUsers();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client _client;

  AuthRemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<void> createUser(
      {required String avatar,
      required String name,
      required String createdAt}) async {
    // TEST-1: check to make sure that it returns the right data
    // TEST-2: check to make sure that it throws a custom exception
    try {
      final response = await _client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'), body: {
      'avatar': avatar,
      'name': name,
      'createdAt': createdAt,
    });
    if(response.statusCode != 200 || response.statusCode != 201) {
      throw ServerException(message: response.body, statusCode: response.statusCode);
    }
    } on ServerException{
      rethrow;
    }
    catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }
}
