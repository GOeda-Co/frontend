import 'package:frontend/api/api.dart';

import '../domain/entities/learning_card.dart';

class LearningController {
  final List<LearningCard> _cards;
  int _currentIndex = 0;

  /// Хранилище ответов пользователя по id карточки
  final Map<String, String> _answers = {};

  LearningController(List<LearningCard> cards)
    : _cards = List.from(cards); // копия для локального состояния

  LearningCard? get currentCard =>
      _currentIndex < _cards.length ? _cards[_currentIndex] : null;

  int get currentIndex => _currentIndex;
  int get total => _cards.length;
  bool get isFinished => _currentIndex >= _cards.length;

  Map<String, String> get answers => _answers;

  List<Map<String, dynamic>> transformToAnswerList(String cardId, String rating) {
  return [
    {
      'card_id': cardId,
      'grade': int.parse(rating),
    }
  ];
}

  /// Пользователь ответил на карту
  void submitAnswer(String cardId, String rating, String deckId) {
    final card = currentCard;
    if (card != null) {
      _answers[card.id] = rating;
      _currentIndex++;
    }

    final answers = transformToAnswerList(cardId, rating);

    print(answers);

    final success = ApiService().submitAnswers(answers);

    print(success);

  }

  /// Повтор текущей карты (не продвигаем индекс)
  void repeatCard() {
    // никакой модификации — просто показываем ту же
  }

  /// Метод для синка с сервером (будущий backend API)
  Future<void> syncProgress() async {
    // final formatted = _answers.entries.map((entry) {
    //   return {'cardId': entry.key, 'rating': entry.value};
    // }).toList();

    // final success = await ApiService().submitAnswers(formatted, card.id);

    // if (!success) {
    //   throw Exception('Failed to sync progress');
    // }
  }
}
