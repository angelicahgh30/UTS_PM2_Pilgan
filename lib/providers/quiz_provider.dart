import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/question.dart';
import '../models/quiz_category.dart';
import '../models/quiz_chapter.dart';
import '../models/quiz_result.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider({this.secondsPerQuestion = 30});

  final int secondsPerQuestion;

  String _userName = '';
  QuizCategory? _category;
  QuizChapter? _chapter;
  List<int?> _answers = [];
  List<bool> _timedOut = [];
  int _currentIndex = 0;
  bool _revealed = false;
  bool _isFinished = false;

  int _combo = 0;
  int _bestCombo = 0;

  int _remaining = 0;
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  DateTime? _finishedAt;

  String get userName => _userName;
  QuizCategory? get category => _category;
  QuizChapter? get chapter => _chapter;
  int get currentIndex => _currentIndex;
  bool get isFinished => _isFinished;
  bool get isRevealed => _revealed;
  bool get isRunning => _chapter != null && !_isFinished;

  List<Question> get questions => _chapter?.questions ?? const [];
  int get totalQuestions => questions.length;
  Question get currentQuestion => questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;

  int? answerAt(int index) => _answers[index];
  int? get currentAnswer => answerAt(_currentIndex);
  bool timedOutAt(int index) => _timedOut[index];
  bool get currentTimedOut => _timedOut[_currentIndex];

  int get answeredCount => _answers.where((a) => a != null).length;
  bool get allAnswered => totalQuestions > 0 && answeredCount == totalQuestions;
  int get doneCount => _currentIndex + (_revealed ? 1 : 0);
  double get progress => totalQuestions == 0 ? 0 : doneCount / totalQuestions;

  int get correctCount {
    var count = 0;
    for (var i = 0; i < totalQuestions; i++) {
      if (questions[i].isCorrect(_answers[i])) count++;
    }
    return count;
  }

  int get timedOutCount => _timedOut.where((t) => t).length;
  int get wrongCount => answeredCount - correctCount;

  int get score =>
      totalQuestions == 0 ? 0 : (correctCount / totalQuestions * 100).round();

  int get combo => _combo;
  int get bestCombo => _bestCombo;

  bool get hasTimer => secondsPerQuestion > 0;
  int get remainingSeconds => _remaining;
  double get timeFraction => hasTimer ? _remaining / secondsPerQuestion : 1;

  Duration get elapsed => _stopwatch.elapsed;

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void startQuiz(QuizCategory category, QuizChapter chapter) {
    _category = category;
    _chapter = chapter;
    _answers = List<int?>.filled(chapter.totalQuestions, null);
    _timedOut = List<bool>.filled(chapter.totalQuestions, false);
    _currentIndex = 0;
    _revealed = false;
    _isFinished = false;
    _combo = 0;
    _bestCombo = 0;
    _stopwatch
      ..reset()
      ..start();
    _finishedAt = null;
    _restartTimer();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (_isFinished || _revealed || _chapter == null) return;
    _answers[_currentIndex] = optionIndex;
    _reveal();
  }

  void _reveal() {
    _timer?.cancel();
    _revealed = true;

    if (currentQuestion.isCorrect(currentAnswer)) {
      _combo++;
      if (_combo > _bestCombo) _bestCombo = _combo;
    } else {
      _combo = 0;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (!_revealed || _isFinished) return;
    if (isLastQuestion) {
      finishQuiz();
      return;
    }
    _currentIndex++;
    _revealed = _answers[_currentIndex] != null || _timedOut[_currentIndex];
    if (!_revealed) _restartTimer();
    notifyListeners();
  }

  void goToQuestion(int index) {
    if (index < 0 || index >= totalQuestions) return;
    _currentIndex = index;
    _revealed = _answers[index] != null || _timedOut[index];
    if (!_revealed) _restartTimer();
    notifyListeners();
  }

  void _restartTimer() {
    _timer?.cancel();
    if (!hasTimer) return;
    _remaining = secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (_remaining > 0) _remaining--;
    if (_remaining == 0) {
      _timedOut[_currentIndex] = true;
      _reveal();
      return;
    }
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    _stopwatch.stop();
  }

  void resume() {
    if (!isRunning) return;
    _stopwatch.start();
    if (!hasTimer || _revealed) return;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void finishQuiz() {
    _timer?.cancel();
    _stopwatch.stop();
    _isFinished = true;
    _finishedAt = DateTime.now();
    notifyListeners();
  }

  QuizResult toResult(String userId) => QuizResult(
    userId: userId,
    categoryId: _category!.id,
    categoryTitle: _category!.title,
    chapterId: _chapter!.id,
    chapterTitle: _chapter!.title,
    chapterNumber: _chapter!.number,
    total: totalQuestions,
    correct: correctCount,
    timedOut: timedOutCount,
    bestCombo: _bestCombo,
    duration: elapsed,
    finishedAt: _finishedAt ?? DateTime.now(),
    answers: List.unmodifiable(_answers),
  );

  void restartQuiz() {
    if (_category != null && _chapter != null) {
      startQuiz(_category!, _chapter!);
    }
  }

  void resetQuiz() {
    _timer?.cancel();
    _stopwatch
      ..stop()
      ..reset();
    _category = null;
    _chapter = null;
    _answers = [];
    _timedOut = [];
    _currentIndex = 0;
    _revealed = false;
    _isFinished = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
