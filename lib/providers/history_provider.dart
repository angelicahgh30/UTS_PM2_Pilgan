import 'package:flutter/foundation.dart';

import '../models/quiz_result.dart';

class HistoryProvider extends ChangeNotifier {
  final List<QuizResult> _results = [];

  void add(QuizResult result) {
    _results.insert(0, result);
    notifyListeners();
  }

  List<QuizResult> resultsOf(String email) =>
      _results.where((r) => r.userEmail == email).toList();

  int averageScore(String email) {
    final list = resultsOf(email);
    if (list.isEmpty) return 0;
    return (list.fold(0, (sum, r) => sum + r.score) / list.length).round();
  }

  int? bestScore(String email, String categoryId) {
    final list = resultsOf(email).where((r) => r.categoryId == categoryId);
    if (list.isEmpty) return null;
    return list.map((r) => r.score).reduce((a, b) => a > b ? a : b);
  }

  int triedCategories(String email) =>
      resultsOf(email).map((r) => r.categoryId).toSet().length;

  int bestCombo(String email) {
    final list = resultsOf(email);
    if (list.isEmpty) return 0;
    return list.map((r) => r.bestCombo).reduce((a, b) => a > b ? a : b);
  }
}
