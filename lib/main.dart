import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/history_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  final AuthProvider? auth;
  final HistoryProvider? history;
  final QuizProvider? quiz;
  final String initialRoute;

  const QuizApp({
    super.key,
    this.auth,
    this.history,
    this.quiz,
    this.initialRoute = AppRoutes.welcome,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        auth != null
            ? ChangeNotifierProvider.value(value: auth!)
            : ChangeNotifierProvider(create: (_) => AuthProvider()),
        history != null
            ? ChangeNotifierProvider.value(value: history!)
            : ChangeNotifierProvider(create: (_) => HistoryProvider()),
        quiz != null
            ? ChangeNotifierProvider.value(value: quiz!)
            : ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp(
          title: 'Kuisin',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: theme.mode,
          initialRoute: initialRoute,
          routes: AppRoutes.routes,
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            child: child!,
          ),
        ),
      ),
    );
  }
}
