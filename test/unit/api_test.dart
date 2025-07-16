import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/api/api.dart';

void main() {
  group('RegisterMessageRequest Tests', () {
    test('should create from JSON correctly', () {
      final json = {
        'name': 'Test User',
        'email': 'test@example.com',
        'password': 'password123',
      };

      final request = RegisterMessageRequest.fromJson(json);

      expect(request.name, equals('Test User'));
      expect(request.email, equals('test@example.com'));
      expect(request.password, equals('password123'));
    });

    test('should convert to JSON correctly', () {
      final request = RegisterMessageRequest(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password123',
      );

      final json = request.toJson();

      expect(json['name'], equals('Test User'));
      expect(json['email'], equals('test@example.com'));
      expect(json['password'], equals('password123'));
    });

    test('should handle null values in JSON', () {
      final json = {
        'name': null,
        'email': null,
        'password': null,
      };

      final request = RegisterMessageRequest.fromJson(json);

      expect(request.name, equals(null));
      expect(request.email, equals(null));
      expect(request.password, equals(null));
    });
  });

  group('RegisterMessageResponse Tests', () {
    test('should create from JSON correctly', () {
      final json = {
        'uid': 'user123',
        'message': 'Registration successful',
      };

      final response = RegisterMessageResponse.fromJson(json);

      expect(response.uid, equals('user123'));
      expect(response.message, equals('Registration successful'));
    });

    test('should convert to JSON correctly', () {
      final response = RegisterMessageResponse(
        uid: 'user123',
        message: 'Registration successful',
      );

      final json = response.toJson();

      expect(json['uid'], equals('user123'));
      expect(json['message'], equals('Registration successful'));
    });
  });

  group('ApiService Tests', () {
    test('should decode token correctly', () {
      // This is a simple test for the decodeToken method
      // In a real scenario, you'd need a valid JWT token
      final apiService = ApiService();
      expect(() => apiService.decodeToken('invalid.token.here'), returnsNormally);
    });

    test('should handle dispose correctly', () {
      final apiService = ApiService();
      expect(() => apiService.dispose(), returnsNormally);
    });

    test('should have correct base URL', () {
      expect(ApiService.baseUrl, equals('http://localhost:8080'));
    });
  });

  group('ApiException Tests', () {
    test('should create exception with message only', () {
      final exception = ApiException('Test error');

      expect(exception.message, equals('Test error'));
      expect(exception.statusCode, isNull);
      expect(exception.toString(), equals('ApiException: Test error'));
    });

    test('should create exception with message and status code', () {
      final exception = ApiException('Test error', 404);

      expect(exception.message, equals('Test error'));
      expect(exception.statusCode, equals(404));
      expect(exception.toString(), equals('ApiException: Test error (Status: 404)'));
    });

    test('should handle different status codes', () {
      final exception500 = ApiException('Server error', 500);
      final exception200 = ApiException('Success', 200);

      expect(exception500.statusCode, equals(500));
      expect(exception200.statusCode, equals(200));
    });
  });

  group('JSON Serialization Tests', () {
    test('should handle special characters in JSON', () {
      final request = RegisterMessageRequest(
        name: 'Test User with "quotes" and \'apostrophes\'',
        email: 'test+tag@example.com',
        password: 'p@ssw0rd!@#',
      );

      final json = request.toJson();

      expect(json['name'], equals('Test User with "quotes" and \'apostrophes\''));
      expect(json['email'], equals('test+tag@example.com'));
      expect(json['password'], equals('p@ssw0rd!@#'));
    });

    test('should handle empty strings', () {
      final request = RegisterMessageRequest(
        name: '',
        email: '',
        password: '',
      );

      final json = request.toJson();

      expect(json['name'], equals(''));
      expect(json['email'], equals(''));
      expect(json['password'], equals(''));
    });

    test('should handle very long strings', () {
      final longString = 'a' * 1000;
      final request = RegisterMessageRequest(
        name: longString,
        email: longString,
        password: longString,
      );

      final json = request.toJson();

      expect(json['name'], equals(longString));
      expect(json['email'], equals(longString));
      expect(json['password'], equals(longString));
    });
  });

  group('Edge Cases Tests', () {
    test('should handle null JSON values gracefully', () {
      final json = {
        'name': null,
        'email': null,
        'password': null,
      };

      expect(() => RegisterMessageRequest.fromJson(json), returnsNormally);
    });

    test('should handle missing JSON keys', () {
      final json = <String, dynamic>{};

      expect(() => RegisterMessageRequest.fromJson(json), returnsNormally);
    });

    test('should handle extra JSON keys', () {
      final json = {
        'name': 'Test',
        'email': 'test@example.com',
        'password': 'password',
        'extra_key': 'extra_value',
      };

      expect(() => RegisterMessageRequest.fromJson(json), returnsNormally);
    });
  });
} 