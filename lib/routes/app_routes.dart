import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/main_shell.dart';
import '../screens/quiz_intro_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../screens/review_screen.dart';
import '../screens/welcome_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const welcome = '/';
  static const login = '/login';
  static const main = '/main';
  static const quizIntro = '/quiz-intro';
  static const quiz = '/quiz';
  static const result = '/result';
  static const review = '/review';

  static Map<String, WidgetBuilder> get routes => {
    welcome: (_) => const WelcomeScreen(),
    login: (_) => const LoginScreen(),
    main: (_) => const MainShell(),
    quizIntro: (_) => const QuizIntroScreen(),
    quiz: (_) => const QuizScreen(),
    result: (_) => const ResultScreen(),
    review: (_) => const ReviewScreen(),
  };
}
