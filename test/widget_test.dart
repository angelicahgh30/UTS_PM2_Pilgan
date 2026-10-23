import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_pilgan/data/quiz_data.dart';
import 'package:quiz_pilgan/main.dart';
import 'package:quiz_pilgan/providers/auth_provider.dart';
import 'package:quiz_pilgan/providers/quiz_provider.dart';

Future<void> pumpApp(WidgetTester tester, {AuthProvider? auth}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(QuizApp(auth: auth));
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  final finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Halaman sambutan hanya punya tombol Mulai', (tester) async {
    await pumpApp(tester);
    expect(find.text('Mulai'), findsOneWidget);
    expect(find.text('Daftar akun baru'), findsNothing);
  });

  testWidgets('Isi nama memvalidasi lalu masuk ke beranda', (tester) async {
    final auth = AuthProvider();
    await pumpApp(tester, auth: auth);
    await tapText(tester, 'Mulai');
    expect(find.text('Siapa namamu?'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tapText(tester, 'Mulai belajar');
    expect(find.text('Nama wajib diisi'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Budi Santoso');
    await tapText(tester, 'Mulai belajar');
    expect(auth.currentUser?.name, 'Budi Santoso');
    expect(find.text('Budi'), findsOneWidget);
  });

  testWidgets('Beranda membuka daftar bab, lalu detail bab', (tester) async {
    final auth = AuthProvider()..enter('Pengguna Demo');
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(QuizApp(auth: auth, initialRoute: '/main'));
    await tester.pumpAndSettle();

    expect(find.text('Pilih materi'), findsOneWidget);
    await tapText(tester, 'Basis Data');
    expect(find.text('Daftar bab'), findsOneWidget);
    expect(find.text('BAB 1'), findsOneWidget);
    expect(find.text('BAB 3'), findsOneWidget);
    await tapText(tester, 'Bahasa SQL');
    expect(find.text('Bab 2'), findsOneWidget);
    expect(find.text('Cara bermain'), findsOneWidget);
    expect(find.text('Mulai kuis'), findsOneWidget);
  });

  testWidgets('Menjawab soal langsung menampilkan feedback', (tester) async {
    final auth = AuthProvider()..enter('Pengguna Demo');
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(QuizApp(auth: auth, initialRoute: '/main'));
    await tester.pumpAndSettle();

    await tapText(tester, 'Basis Data');
    await tapText(tester, 'Konsep Dasar Basis Data');
    await tapText(tester, 'Mulai kuis');
    expect(find.text('Soal 1 dari 5'), findsOneWidget);

    final first = quizCategories[1].chapters.first.questions.first;
    await tapText(tester, first.correctAnswer);
    expect(find.text('Jawaban kamu benar!'), findsOneWidget);
    expect(find.text('1 benar'), findsOneWidget);

    await tapText(tester, 'Soal berikutnya');
    expect(find.text('Soal 2 dari 5'), findsOneWidget);
  });

  testWidgets('Soal terakhir membuka hasil, lalu pembahasan', (tester) async {
    final auth = AuthProvider()..enter('Pengguna Demo');
    final quiz = QuizProvider(secondsPerQuestion: 0)
      ..setUserName('Pengguna Demo')
      ..startQuiz(quizCategories.first, quizCategories.first.chapters.first);
    for (var i = 0; i < quiz.totalQuestions - 1; i++) {
      quiz
        ..selectAnswer(quiz.currentQuestion.correctIndex)
        ..nextQuestion();
    }
    quiz.selectAnswer((quiz.currentQuestion.correctIndex + 1) % 4);

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      QuizApp(auth: auth, quiz: quiz, initialRoute: '/quiz'),
    );
    await tester.pumpAndSettle();

    await tapText(tester, 'Lihat hasil');
    expect(find.text('Luar biasa, Pengguna!'), findsOneWidget);
    expect(find.text('80'), findsOneWidget);

    await tapText(tester, 'Lihat pembahasan');
    await tapText(tester, 'Salah (1)');
    expect(find.text('Salah'), findsWidgets);
    expect(find.textContaining('Jawaban benar'), findsWidgets);
  });

  testWidgets('Riwayat kosong lalu keluar akun kembali ke sambutan', (
    tester,
  ) async {
    final auth = AuthProvider()..enter('Pengguna Demo');
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(QuizApp(auth: auth, initialRoute: '/main'));
    await tester.pumpAndSettle();

    await tapText(tester, 'Riwayat');
    expect(find.text('Belum ada riwayat'), findsOneWidget);
    await tapText(tester, 'Mulai belajar');
    expect(find.text('Pilih materi'), findsOneWidget);

    await tapText(tester, 'Profil');
    await tapText(tester, 'Keluar');
    await tapText(tester, 'Keluar');
    expect(auth.isLoggedIn, isFalse);
    expect(find.text('Mulai'), findsOneWidget);
  });
}
