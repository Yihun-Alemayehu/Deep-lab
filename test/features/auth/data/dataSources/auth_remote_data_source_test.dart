import 'dart:convert';

import 'package:deep_lab/core/error/exceptions.dart';
import 'package:deep_lab/core/error/failure.dart';
import 'package:deep_lab/core/utils/constants.dart';
import 'package:deep_lab/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:deep_lab/features/auth/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    client = MockClient();
    dataSource = AuthRemoteDataSourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully', () async {
      // Arrange
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      // Act
      final methodCall = dataSource.createUser;

      // Assert
      expect(
          () => methodCall(
              avatar: 'avatar', name: 'name', createdAt: 'createdAt'),
          completes);

      verify(() => client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
          body: jsonEncode({
            'avatar': 'avatar',
            'name': 'name',
            'createdAt': 'createdAt',
          }))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the response code is not 201 or 200',
        () async {
      // Arrange
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('User not created', 400));

      // Act
      final methodCall = dataSource.createUser;

      // Assert
      expect(
          () async => methodCall(
              avatar: 'avatar', name: 'name', createdAt: 'createdAt'),
          throwsA(
              const ApiFailure(message: 'user not created', statusCode: 400)));

      verify(() => client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
          body: jsonEncode({
            'avatar': 'avatar',
            'name': 'name',
            'createdAt': 'createdAt',
          }))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getAllUsers', () {
    final tUser = [UserModel.empty()];
    test('should return [List<UserModel>] when the status code is 200',
        () async {
      // Arrange
      when(
        () => client.get(any()),
      ).thenAnswer(
          (_) async => http.Response(jsonEncode([tUser.first.toMap()]), 200));

      // Act
      final result = await dataSource.getAllUsers();

      // Assert
      expect(result, equals(tUser));
      verify(() => client.get(Uri.https(kBase, kGetAllUsers))).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
        'should throw an [ServerException] when the status code is not 200 or 201',
        () {
      // Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Server Down', 500));

      // Act
      final methodCall = dataSource.getAllUsers;

      // Assert
      expect(() async=> methodCall(), throwsA(const ServerException(message: 'Server Down',statusCode : 500)));
      verify(() => client.get(Uri.https(kBase, kGetAllUsers))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
