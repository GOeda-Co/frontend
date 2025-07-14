import 'package:equatable/equatable.dart';

class LearningCard extends Equatable {
  final String id;
  final String front;
  final String back;

  const LearningCard({
    required this.id,
    required this.front,
    required this.back,
  });

  factory LearningCard.fromJson(Map<String, dynamic> json) {
    return LearningCard(
      id: json['id'] as String,
      front: json['front'] as String,
      back: json['back'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'front': front,
    'back': back,
  };

  @override
  List<Object?> get props => [id, front, back];
}