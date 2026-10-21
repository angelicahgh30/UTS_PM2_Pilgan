import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_pilgan/main.dart';
import 'package:quiz_pilgan/providers/auth_provider.dart';

void main() {
  Brightness brightnessOf(WidgetTester tester) =>
      Theme.of(tester.element(find.byType(Scaffold).last)).brightness;

  testWidgets('Tombol di halaman sambutan mengganti tema', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const QuizApp());
    await tester.pumpAndSettle();

    expect(brightnessOf(tester), Brightness.light);
    await tester.tap(find.byTooltip('Mode gelap'));
    await tester.pumpAndSettle();
    expect(brightnessOf(tester), Brightness.dark);
  });

  testWidgets('Switch mode gelap di profil', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final auth = AuthProvider()
      ..enter('Pengguna Demo');
    await tester.pumpWidget(QuizApp(auth: auth, initialRoute: '/main'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(Switch));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(brightnessOf(tester), Brightness.dark);
  });
}
