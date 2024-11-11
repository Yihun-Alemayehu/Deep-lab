import 'dart:convert';

import 'package:deep_lab/features/auth/data/model/user_model.dart';
import 'package:deep_lab/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = UserModel.empty();
  test('should be the sub class of [UserEntity]', () {
    // Arrange

    // Act

    // Assert
    expect(tModel, isA<UserEntity>());
  });

  final tJson = fixture('user.json');

  final tMap = jsonDecode(tJson) as Map<String, dynamic>;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Arrange

      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] with the right data', () {
      // Arrange
      final jsonData = jsonEncode({
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "id": "1"
      });

      // Act
      final result = tModel.toJson();

      // Assert
      expect(result, equals(jsonData));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Arrange

      // Act
      final result = tModel.copyWith(name: 'Yihun');

      // Assert
      expect(result.name, equals('Yihun'));
    });
  });
}
