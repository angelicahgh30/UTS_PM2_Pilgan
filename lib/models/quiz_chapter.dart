import 'question.dart';

class QuizChapter {
  final String id;
  final int number;
  final String title;
  final String description;
  final List<Question> questions;

  const QuizChapter({
    required this.id,
    required this.number,
    required this.title,
    required this.description,
    required this.questions,
  });

  int get totalQuestions => questions.length;

  String get label => 'Bab $number';
}
