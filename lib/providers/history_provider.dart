import 'package:flutter/foundation.dart';

import '../models/quiz_category.dart';
import '../models/quiz_result.dart';

class HistoryProvider extends ChangeNotifier {
  final List<QuizResult> _results = [];

  void add(QuizResult result) {
    _results.insert(0, result);
    notifyListeners();
  }

  List<QuizResult> resultsOf(String userId) =>
      _results.where((r) => r.userId == userId).toList();

  int averageScore(String userId) {
    final list = resultsOf(userId);
    if (list.isEmpty) return 0;
    return (list.fold(0, (sum, r) => sum + r.score) / list.length).round();
  }

  /// Nilai terbaik pengguna pada satu bab, atau null jika belum dikerjakan.
  int? bestChapterScore(String userId, String chapterId) {
    final list = resultsOf(userId).where((r) => r.chapterId == chapterId);
    if (list.isEmpty) return null;
    return list.map((r) => r.score).reduce((a, b) => a > b ? a : b);
  }

  /// Jumlah bab pada satu materi yang sudah pernah diselesaikan.
  int completedChapters(String userId, QuizCategory category) => category
      .chapters
      .where((c) => bestChapterScore(userId, c.id) != null)
      .length;

  /// Jumlah semua bab (dari semua materi) yang sudah pernah diselesaikan.
  int totalCompletedChapters(String userId) =>
      resultsOf(userId).map((r) => r.chapterId).toSet().length;

  /// Rata-rata nilai terbaik dari bab yang sudah dikerjakan pada satu materi.
  int? categoryScore(String userId, QuizCategory category) {
    final scores = [
      for (final chapter in category.chapters)
        ?bestChapterScore(userId, chapter.id),
    ];
    if (scores.isEmpty) return null;
    return (scores.reduce((a, b) => a + b) / scores.length).round();
  }

  int triedCategories(String userId) =>
      resultsOf(userId).map((r) => r.categoryId).toSet().length;

  int bestCombo(String userId) {
    final list = resultsOf(userId);
    if (list.isEmpty) return 0;
    return list.map((r) => r.bestCombo).reduce((a, b) => a > b ? a : b);
  }
}
