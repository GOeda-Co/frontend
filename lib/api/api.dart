import 'dart:convert';
// import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:frontend/pages/log_in_screen/log_in_screen.dart';
import 'package:frontend/sso/interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class RegisterMessageRequest {
  final String email;
  final String password;
  final String name;

  const RegisterMessageRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegisterMessageRequest.fromJson(Map<String, dynamic> json) {
    return RegisterMessageRequest(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}

class RegisterMessageResponse {
  final String uid;
  final String message;

  const RegisterMessageResponse({required this.uid, required this.message});

  factory RegisterMessageResponse.fromJson(Map<String, dynamic> json) {
    return RegisterMessageResponse(uid: json['uid'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'message': message};
  }
}

class ApiService {
  static const String baseUrl = 'http://localhost:8080';

  static final Dio dio = Dio()..interceptors.add(AuthInterceptor());

  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<String?> register(String email, String password, String name) async {
    try {
      final userUpdateUrl = Uri.parse('http://localhost:8080/register');
      // final request = RegisterMessageRequest(
      //   email: "asa@mail.ru",
      //   password: "cock",
      //   name: "name",
      // );
      //
      // final userUpdate = {'id': userId, 'name': name, 'email': email};
      final userUpdateResponse = await http.post(
        userUpdateUrl,
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
        headers: {'Content-Type': 'application/json'},
      );
      if (userUpdateResponse.statusCode != 200) {
        print('Failed to update user data!');
        return null;
      }

      return userUpdateResponse.body;
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  void decodeToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    print('Decoded payload: $decodedToken');

    final userId = decodedToken['sub'] ?? decodedToken['id'];
    final email = decodedToken['email'];
    final role = decodedToken['role'];

    print('User ID: $userId');
    print('Email: $email');
    print('Role: $role');
  }

  Future<String?> login(String email, String password, int appId) async {
    try {
      final userUpdateUrl = Uri.parse('http://localhost:8080/login');
      // final request = RegisterMessageRequest(
      //   email: "asa@mail.ru",
      //   password: "cock",
      //   name: "name",
      // );
      //
      // final userUpdate = {'id': userId, 'name': name, 'email': email};
      final userUpdateResponse = await http.post(
        userUpdateUrl,
        body: jsonEncode({
          'email': email,
          'password': password,
          'app_id': appId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (userUpdateResponse.statusCode != 200) {
        print('Failed to update user data!');
        print('Reponse: ${userUpdateResponse.body}');
        return null;
      }

      return userUpdateResponse.body;
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
  // Health check endpoint
  // Future<Map<String, dynamic>> healthCheck() async {
  //   try {
  //     final response = await _client.get(
  //       Uri.parse('http://localhost:8080/health'),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       throw ApiException('Health check failed', response.statusCode);
  //     }
  //   } catch (e) {
  //     throw ApiException('Failed to connect to server: $e');
  //   }
  // }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}
