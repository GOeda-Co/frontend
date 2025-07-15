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

  Future<String?> addCard({
    required String word,
    required String translation,
  }) async {
    final url = Uri.parse('http://localhost:8080/cards');

    final cardData = {'word': word, 'translation': translation};

    try {
      final response = await ApiService.dio.post(
        'http://localhost:8080/cards',
        data: cardData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print('Failed to add card. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while adding card: $e');
    }
    return null;
  }

  Future<String?> addCardString({
    required String word,
    required String translation,
  }) async {
    final url = Uri.parse('http://localhost:8080/cards');

    final cardData = {'word': word, 'translation': translation};

    try {
      final response = await ApiService.dio.post(
        'http://localhost:8080/cards',
        data: cardData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['card_id'];
      } else {
        print('Failed to add card. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while adding card: $e');
    }
    return null;
  }

  static Future<List<dynamic>?> getAllCards() async {
    final url = Uri.parse('http://localhost:8080/cards');

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data; // List of card maps
      } else {
        print('Failed to fetch cards. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching cards: $e');
    }

    return null;
  }

  Future<Map<String, dynamic>?> addDeck({
    required String name,
    required String description,
  }) async {
    final url = Uri.parse('http://localhost:8080/decks');

    final deckData = {'name': name, 'description': description};

    try {
      final response = await ApiService.dio.post(
        url.toString(),
        data: deckData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        print('Failed to add deck. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while adding deck: $e');
    }
  }

  static Future<List<Map<String, dynamic>>?> getAllDecksAsSimpleMap() async {
    final url = Uri.parse('http://localhost:8080/decks');

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data is List) {
        final List decks = response.data;

        return decks.map<Map<String, dynamic>>((deck) {
          return {
            'title': deck['name'] ?? 'Untitled',
            'cards': deck['cards_quantity'] ?? 0,
            'deck_id': deck['deck_id'] ?? 0,
          };
        }).toList();
      } else {
        print('Failed to fetch decks. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching decks: $e');
    }

    return null;
  }

  static Future<int?> getCardsReviewedCount() async {
    final url = Uri.parse('http://localhost:8080/stats/count');

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return (response.data as num).toInt();
      } else {
        print(
          'Failed to get cards reviewed count. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error getting reviewed count: $e');
    }

    return null;
  }

  Future<bool> addCardToDeck({
    required String deckId,
    required String cardId,
  }) async {
    final url = Uri.parse('http://localhost:8080/decks/$deckId/cards/$cardId');

    try {
      final response = await ApiService.dio.post(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to add card to deck. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while adding card to deck: $e');
    }
    return false;
  }

  static Future<double?> getAverageGrade() async {
    final url = Uri.parse('http://localhost:8080/stats/average');

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return (response.data as num).toDouble(); // Handles int/float safely
      } else {
        print('Failed to get average grade. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting average grade: $e');
    }
    return null;
  }

  Future<List<dynamic>?> getCardsByDeckId(String deckId) async {
    final url = Uri.parse('http://localhost:8080/decks/$deckId/cards');

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data as List;
      } else {
        print('Failed to fetch cards for deck. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deck cards: $e');
    }

    return null;
  }

  Future<bool> deleteDeck(String deckId) async {
    try {
      final response = await dio.delete('http://localhost:8080/decks/$deckId');
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting deck: $e');
      return false;
    }
  }

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
