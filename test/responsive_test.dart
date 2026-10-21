import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_pilgan/data/quiz_data.dart';
import 'package:quiz_pilgan/main.dart';
import 'package:quiz_pilgan/providers/auth_provider.dart';
import 'package:quiz_pilgan/providers/history_provider.dart';
import 'package:quiz_pilgan/providers/quiz_provider.dart';

const screenSizes = {
  'HP kecil': Size(320, 568),
  'HP': Size(390, 844),
  'HP landscape': Size(844, 390),
  'Tablet': Size(820, 1180),
  'Web': Size(1440, 900),
};

Future<void> pumpAt(
  WidgetTester tester,
  Size size, {
  required String route,
  bool finished = false,
  String? tapText,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final auth = AuthProvider()
    ..enter('Angelica Happy Grace Harianja');
  final history = HistoryProvider();
  final quiz = QuizProvider(secondsPerQuestion: 0)
    ..setUserName(auth.currentUser!.name)
    ..startQuiz(quizCategories.last);
  for (var i = 0; i < 4; i++) {
    quiz
      ..selectAnswer(i % 4)
      ..nextQuestion();
  }
  if (finished) {
    while (!quiz.isFinished) {
      quiz
        ..selectAnswer(0)
        ..nextQuestion();
    }
    history.add(quiz.toResult(auth.currentUser!.id));
  }

  await tester.pumpWidget(
    QuizApp(auth: auth, history: history, quiz: quiz, initialRoute: route),
  );
  await tester.pumpAndSettle();
  if (tapText != null) {
    await tester.tap(find.text(tapText).last);
    await tester.pumpAndSettle();
  }
}

void main() {
  for (final entry in screenSizes.entries) {
    final size = entry.value;
    group('${entry.key} $size', () {
      testWidgets('Sambutan', (tester) async {
        await pumpAt(tester, size, route: '/');
        expect(tester.takeException(), isNull);
      });

      testWidgets('Isi nama', (tester) async {
        await pumpAt(tester, size, route: '/login');
        expect(tester.takeException(), isNull);
      });

      testWidgets('Beranda', (tester) async {
        await pumpAt(tester, size, route: '/main');
        expect(tester.takeException(), isNull);
      });

      testWidgets('Detail materi', (tester) async {
        await pumpAt(tester, size, route: '/main', tapText: 'Basis Data');
        expect(tester.takeException(), isNull);
      });

      testWidgets('Kuis', (tester) async {
        await pumpAt(tester, size, route: '/quiz');
        expect(tester.takeException(), isNull);
      });

      testWidgets('Hasil', (tester) async {
        await pumpAt(tester, size, route: '/result', finished: true);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Pembahasan', (tester) async {
        await pumpAt(
          tester,
          size,
          route: '/result',
          finished: true,
          tapText: 'Lihat pembahasan',
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('Riwayat', (tester) async {
        await pumpAt(
          tester,
          size,
          route: '/main',
          finished: true,
          tapText: 'Riwayat',
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('Profil', (tester) async {
        await pumpAt(
          tester,
          size,
          route: '/main',
          finished: true,
          tapText: 'Profil',
        );
        expect(tester.takeException(), isNull);
      });
    });
  }
}
