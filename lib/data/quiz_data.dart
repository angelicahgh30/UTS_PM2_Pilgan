import '../models/quiz_category.dart';
import 'materi/arsitektur_komputer.dart';
import 'materi/basis_data.dart';
import 'materi/jaringan_komputer.dart';
import 'materi/pemrograman_mobile.dart';

const List<QuizCategory> quizCategories = [
  pemrogramanMobile,
  basisData,
  jaringanKomputer,
  arsitekturKomputer,
];

QuizCategory categoryById(String id) =>
    quizCategories.firstWhere((c) => c.id == id);

int get totalChapters =>
    quizCategories.fold(0, (sum, c) => sum + c.totalChapters);

int get totalQuestions =>
    quizCategories.fold(0, (sum, c) => sum + c.totalQuestions);
