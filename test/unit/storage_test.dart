import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/sso/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  group('SecureStorage Tests', () {
    test('should write and read values correctly', () async {
      const key = 'test_key';
      const value = 'test_value';

      await SecureStorage.write(key, value);
      final result = await SecureStorage.read(key);

      expect(result, equals(value));
    });

    test('should return null for non-existent key', () async {
      const key = 'non_existent_key';
      final result = await SecureStorage.read(key);

      expect(result, isNull);
    });

    test('should delete values correctly', () async {
      const key = 'delete_test_key';
      const value = 'delete_test_value';

      await SecureStorage.write(key, value);
      await SecureStorage.delete(key);
      final result = await SecureStorage.read(key);

      expect(result, isNull);
    });

    test('should handle empty string values', () async {
      const key = 'empty_key';
      const value = '';

      await SecureStorage.write(key, value);
      final result = await SecureStorage.read(key);

      expect(result, equals(value));
    });
  });

  group('TokenStorage Tests', () {
    test('should save and retrieve token correctly', () async {
      const token = 'test_token_123';

      await TokenStorage.saveToken(token);
      final result = await TokenStorage.getToken();

      expect(result, equals(token));
    });

    test('should return null when no token is stored', () async {
      // Clear any existing token
      await TokenStorage.clearToken();
      final result = await TokenStorage.getToken();

      expect(result, isNull);
    });

    test('should clear token correctly', () async {
      const token = 'clear_test_token';

      await TokenStorage.saveToken(token);
      await TokenStorage.clearToken();
      final result = await TokenStorage.getToken();

      expect(result, isNull);
    });

    test('should overwrite existing token', () async {
      const firstToken = 'first_token';
      const secondToken = 'second_token';

      await TokenStorage.saveToken(firstToken);
      await TokenStorage.saveToken(secondToken);
      final result = await TokenStorage.getToken();

      expect(result, equals(secondToken));
    });

    test('should handle empty token', () async {
      const token = '';

      await TokenStorage.saveToken(token);
      final result = await TokenStorage.getToken();

      expect(result, equals(token));
    });
  });


} 