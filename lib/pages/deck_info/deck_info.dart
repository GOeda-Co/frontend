import 'package:flutter/material.dart';
import 'package:frontend/layout/app_shell.dart';
import 'package:frontend/features/learning/presentation/pages/learning_page.dart';
import 'package:frontend/features/learning/domain/entities/learning_card.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  final List<String> cards = ['SUN', 'MOON', 'STAR', 'EARTH', 'PLANET'];
  int currentIndex = 0;

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % cards.length;
    });
  }

  void prevCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + cards.length) % cards.length;
    });
  }

  void onStudyPressed() {
  final learningCards = cards.asMap().entries.map((entry) {
    final index = entry.key;
    final word = entry.value;
    return LearningCard(
      id: index.toString(),       // можно заменить на uuid или backend id
      front: word,
      back: 'Значение $word',     // временно; заменишь на реальный перевод/ответ
    );
  }).toList();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => LearningPage(cards: learningCards),
    ),
  );
}

  void onDeletePressed() {
    // TODO: Реализовать удаление
    print('Delete pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('D1-20'),
        actions: [
          TextButton.icon(
            onPressed: onStudyPressed,
            icon: Icon(
              Icons.keyboard_return,
              color: Theme.of(context).primaryColor,
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            label: Text(
              'Study',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          TextButton.icon(
            onPressed: onDeletePressed,
            icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            label: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Карточка
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 50),
            width: 450,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              cards[currentIndex],
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 30),

          // Стрелки
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: prevCard,
                icon: Icon(
                  Icons.arrow_left,
                  size: 32,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: nextCard,
                icon: Icon(
                  Icons.arrow_right,
                  size: 32,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
