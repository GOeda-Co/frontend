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

  /// Пользователь ответил на карту
  void submitAnswer(String rating) {
    final card = currentCard;
    if (card != null) {
      _answers[card.id] = rating;
      _currentIndex++;
    }
  }

  /// Повтор текущей карты (не продвигаем индекс)
  void repeatCard() {
    // никакой модификации — просто показываем ту же
  }

  /// Метод для синка с сервером (будущий backend API)
  Future<void> syncProgress() async {
    // TODO: отправка _answers в backend
    // например:
    // await backendApi.sendProgress(_answers);
  }
}