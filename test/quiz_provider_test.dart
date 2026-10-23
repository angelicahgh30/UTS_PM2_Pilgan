import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_pilgan/data/quiz_data.dart';
import 'package:quiz_pilgan/providers/auth_provider.dart';
import 'package:quiz_pilgan/providers/history_provider.dart';
import 'package:quiz_pilgan/providers/quiz_provider.dart';

void main() {
  group('QuizProvider', () {
    test('Skor dihitung dari jawaban yang benar', () {
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..setUserName('  Budi  ')
        ..startQuiz(quizCategories.first, quizCategories.first.chapters.first);

      expect(quiz.userName, 'Budi');
      expect(quiz.answeredCount, 0);

      for (var i = 0; i < quiz.totalQuestions; i++) {
        final correct = quiz.currentQuestion.correctIndex;
        quiz.selectAnswer(quiz.isLastQuestion ? (correct + 1) % 4 : correct);
        quiz.nextQuestion();
      }

      expect(quiz.isFinished, isTrue);
      expect(quiz.correctCount, quiz.totalQuestions - 1);
      final expected = ((quiz.totalQuestions - 1) / quiz.totalQuestions * 100)
          .round();
      expect(quiz.score, expected);
    });

    test('Jawaban dikunci setelah dipilih', () {
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..startQuiz(quizCategories.first, quizCategories.first.chapters.first)
        ..selectAnswer(0)
        ..selectAnswer(1);
      expect(quiz.currentAnswer, 0);
      expect(quiz.isRevealed, isTrue);
    });

    test('Combo bertambah saat benar dan kembali 0 saat salah', () {
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..startQuiz(quizCategories.first, quizCategories.first.chapters.first);
      for (var i = 0; i < 3; i++) {
        quiz
          ..selectAnswer(quiz.currentQuestion.correctIndex)
          ..nextQuestion();
      }
      expect(quiz.combo, 3);

      quiz.selectAnswer((quiz.currentQuestion.correctIndex + 1) % 4);
      expect(quiz.combo, 0);
      expect(quiz.bestCombo, 3);
    });

    test('Restart mengosongkan jawaban tapi nama tetap', () {
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..setUserName('Ani')
        ..startQuiz(quizCategories.first, quizCategories.first.chapters.first)
        ..selectAnswer(0)
        ..restartQuiz();

      expect(quiz.userName, 'Ani');
      expect(quiz.answeredCount, 0);
      expect(quiz.currentIndex, 0);
      expect(quiz.combo, 0);
    });

    test('Waktu habis menandai soal dan menguncinya', () {
      fakeAsync((async) {
        final quiz = QuizProvider(
          secondsPerQuestion: 5,
        )..startQuiz(quizCategories.first, quizCategories.first.chapters.first);
        async.elapse(const Duration(seconds: 3));
        expect(quiz.remainingSeconds, 2);

        async.elapse(const Duration(seconds: 2));
        expect(quiz.currentTimedOut, isTrue);
        expect(quiz.isRevealed, isTrue);
        expect(quiz.combo, 0);
        quiz.dispose();
      });
    });

    test('Timer berhenti saat pause dan lanjut saat resume', () {
      fakeAsync((async) {
        final quiz = QuizProvider(
          secondsPerQuestion: 10,
        )..startQuiz(quizCategories.first, quizCategories.first.chapters.first);
        async.elapse(const Duration(seconds: 2));
        quiz.pause();
        async.elapse(const Duration(seconds: 5));
        expect(quiz.remainingSeconds, 8);
        quiz.resume();
        async.elapse(const Duration(seconds: 1));
        expect(quiz.remainingSeconds, 7);
        quiz.dispose();
      });
    });
  });

  group('Data bab', () {
    test('Setiap materi punya 3 bab, setiap bab 5 soal', () {
      for (final category in quizCategories) {
        expect(category.chapters, hasLength(3));
        for (final chapter in category.chapters) {
          expect(chapter.questions, hasLength(5));
          for (final q in chapter.questions) {
            expect(q.correctIndex, inInclusiveRange(0, q.options.length - 1));
          }
        }
      }
    });

    test('Kuis hanya memakai soal dari bab yang dipilih', () {
      final category = quizCategories[2];
      final chapter = category.chapters[1];
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..startQuiz(category, chapter);
      expect(quiz.chapter, chapter);
      expect(quiz.totalQuestions, chapter.totalQuestions);
      expect(quiz.currentQuestion, chapter.questions.first);
      while (!quiz.isFinished) {
        quiz
          ..selectAnswer(quiz.currentQuestion.correctIndex)
          ..nextQuestion();
      }
      final result = quiz.toResult('budi');
      expect(result.chapterId, chapter.id);
      expect(result.chapterNumber, 2);
    });
  });

  group('AuthProvider', () {
    test('Masuk cukup dengan nama, lalu keluar', () {
      final auth = AuthProvider()..enter('  Siti   Aminah ');
      expect(auth.currentUser!.name, 'Siti Aminah');
      expect(auth.currentUser!.id, 'siti aminah');
      expect(auth.currentUser!.initials, 'SA');

      auth.logout();
      expect(auth.isLoggedIn, isFalse);
    });
  });

  group('HistoryProvider', () {
    test('Statistik dihitung per akun', () {
      final history = HistoryProvider();
      final quiz = QuizProvider(secondsPerQuestion: 0)
        ..startQuiz(quizCategories.first, quizCategories.first.chapters.first);
      while (!quiz.isFinished) {
        quiz
          ..selectAnswer(quiz.currentQuestion.correctIndex)
          ..nextQuestion();
      }
      history.add(quiz.toResult('angelica'));

      expect(history.resultsOf('angelica'), hasLength(1));
      expect(history.resultsOf('budi'), isEmpty);
      expect(history.averageScore('angelica'), 100);
      final category = quizCategories.first;
      expect(
        history.bestChapterScore('angelica', category.chapters.first.id),
        100,
      );
      expect(
        history.bestChapterScore('angelica', category.chapters[1].id),
        isNull,
      );
      expect(history.completedChapters('angelica', category), 1);
      expect(history.totalCompletedChapters('angelica'), 1);
      expect(history.categoryScore('angelica', category), 100);
      expect(history.triedCategories('angelica'), 1);
    });
  });
}
