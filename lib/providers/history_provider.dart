import 'package:flutter/foundation.dart';

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

  int? bestScore(String userId, String categoryId) {
    final list = resultsOf(userId).where((r) => r.categoryId == categoryId);
    if (list.isEmpty) return null;
    return list.map((r) => r.score).reduce((a, b) => a > b ? a : b);
  }

  int triedCategories(String userId) =>
      resultsOf(userId).map((r) => r.categoryId).toSet().length;

  int bestCombo(String userId) {
    final list = resultsOf(userId);
    if (list.isEmpty) return 0;
    return list.map((r) => r.bestCombo).reduce((a, b) => a > b ? a : b);
  }
}
