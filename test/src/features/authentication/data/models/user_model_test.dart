import 'dart:convert';

import 'package:dummy_app_with_bloc/src/features/authentication/data/models/user_model.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = UserModel.empty();

  final Map<String, dynamic> jsonMap =
      json.decode(fixtureReader('authentication/user.json'));

  final tUserModel = UserModel(
    id: jsonMap['id'],
    name: jsonMap['name'],
    createdAt: DateTime.tryParse(jsonMap['createdAt'])!,
    avatar: jsonMap['avatar'],
  );
  test('Should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('Should return a [UserModel]', () async {
      final result = UserModel.fromMap(jsonMap);

      expect(result, isA<User>());
    });
  });

  group('toMap', () {
    test('Should return a map containing the proper data', () {
      final result = tUserModel.toMap();

      expect(result, jsonMap);
    });
  });
}
