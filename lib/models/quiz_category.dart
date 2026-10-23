import 'package:flutter/material.dart';

import 'quiz_chapter.dart';

class QuizCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<QuizChapter> chapters;

  const QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.chapters,
  });

  int get totalChapters => chapters.length;

  int get totalQuestions =>
      chapters.fold(0, (sum, chapter) => sum + chapter.totalQuestions);

  QuizChapter chapterById(String chapterId) =>
      chapters.firstWhere((c) => c.id == chapterId);
}
