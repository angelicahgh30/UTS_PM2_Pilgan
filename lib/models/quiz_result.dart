class QuizResult {
  final String userId;
  final String categoryId;
  final String categoryTitle;
  final String chapterId;
  final String chapterTitle;
  final int chapterNumber;
  final int total;
  final int correct;
  final int timedOut;
  final int bestCombo;
  final Duration duration;
  final DateTime finishedAt;
  final List<int?> answers;

  const QuizResult({
    required this.userId,
    required this.categoryId,
    required this.categoryTitle,
    required this.chapterId,
    required this.chapterTitle,
    required this.chapterNumber,
    required this.total,
    required this.correct,
    required this.timedOut,
    required this.bestCombo,
    required this.duration,
    required this.finishedAt,
    required this.answers,
  });

  int get wrong => total - correct - timedOut;
  int get score => total == 0 ? 0 : (correct / total * 100).round();
}
