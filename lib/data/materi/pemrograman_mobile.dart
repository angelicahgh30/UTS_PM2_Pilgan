import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/quiz_category.dart';
import '../../models/quiz_chapter.dart';

const pemrogramanMobile = QuizCategory(
  id: 'mobile',
  title: 'Pemrograman Mobile',
  description: 'Flutter, Dart, dan widget',
  icon: Icons.phone_android_rounded,
  color: Color(0xFF6C5CE7),
  chapters: [
    QuizChapter(
      id: 'mobile_1',
      number: 1,
      title: 'Dasar Flutter dan Dart',
      description: 'Bahasa Dart, struktur proyek, dan hot reload',
      questions: [
        Question(
          text: 'Bahasa pemrograman yang digunakan oleh Flutter adalah...',
          options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
          correctIndex: 2,
          explanation:
              'Flutter dikembangkan oleh Google dan memakai bahasa Dart.',
        ),
        Question(
          text: 'Fungsi yang menjadi titik awal program Dart adalah...',
          options: ['start()', 'main()', 'run()', 'init()'],
          correctIndex: 1,
          explanation:
              'Program Dart selalu dimulai dari fungsi main(). Di Flutter, '
              'main() memanggil runApp().',
        ),
        Question(
          text: 'File yang digunakan untuk mengatur dependensi, aset, dan font pada proyek Flutter adalah...',
          options: [
            'main.dart',
            'pubspec.yaml',
            'build.gradle',
            'AndroidManifest.xml',
          ],
          correctIndex: 1,
        ),
        Question(
          text: 'Fitur Flutter yang menerapkan perubahan kode tanpa menghilangkan state aplikasi adalah...',
          options: ['Hot Restart', 'Hot Reload', 'Full Rebuild', 'Cold Boot'],
          correctIndex: 1,
          explanation: 'Hot Reload mempertahankan state, sedangkan Hot Restart mengulang aplikasi dari awal.',
        ),
        Question(
          text: 'Sistem operasi mobile yang dikembangkan oleh Google adalah...',
          options: ['iOS', 'Android', 'HarmonyOS', 'Windows Phone'],
          correctIndex: 1,
        ),
      ],
    ),
    QuizChapter(
      id: 'mobile_2',
      number: 2,
      title: 'Widget dan Layout',
      description: 'Stateless, Stateful, dan penyusunan tampilan',
      questions: [
        Question(
          text: 'Widget yang memiliki state yang dapat berubah disebut...',
          options: [
            'StatelessWidget',
            'StatefulWidget',
            'InheritedWidget',
            'RenderObject',
          ],
          correctIndex: 1,
          explanation: 'StatefulWidget memiliki objek State yang bisa diperbarui saat aplikasi berjalan.',
        ),
        Question(
          text: 'Method yang dipanggil untuk memberi tahu Flutter bahwa state berubah adalah...',
          options: ['initState()', 'setState()', 'dispose()', 'build()'],
          correctIndex: 1,
          explanation: 'setState() menandai widget agar dibangun ulang dengan data terbaru.',
        ),
        Question(
          text:
              'Widget untuk menyusun beberapa widget secara vertikal adalah...',
          options: ['Row', 'Stack', 'Column', 'Wrap'],
          correctIndex: 2,
        ),
        Question(
          text: 'Widget untuk menumpuk beberapa widget di atas satu sama lain adalah...',
          options: ['Column', 'Stack', 'ListView', 'Expanded'],
          correctIndex: 1,
          explanation: 'Stack menumpuk anak-anaknya. Posisinya bisa diatur dengan Positioned.',
        ),
        Question(
          text: 'Widget kerangka halaman Material yang menyediakan AppBar, body, dan FloatingActionButton adalah...',
          options: ['Container', 'Scaffold', 'MaterialApp', 'SafeArea'],
          correctIndex: 1,
        ),
      ],
    ),
    QuizChapter(
      id: 'mobile_3',
      number: 3,
      title: 'Navigasi, Responsif, dan State',
      description: 'Pindah halaman, ukuran layar, dan Provider',
      questions: [
        Question(
          text: 'Method Navigator untuk berpindah ke halaman baru adalah...',
          options: [
            'Navigator.pop',
            'Navigator.push',
            'Navigator.remove',
            'Navigator.close',
          ],
          correctIndex: 1,
          explanation: 'Navigator.push menambah halaman baru ke tumpukan, Navigator.pop kembali ke halaman sebelumnya.',
        ),
        Question(
          text: 'Method untuk berpindah halaman memakai nama rute, misalnya "/login", adalah...',
          options: [
            'Navigator.pushNamed',
            'Navigator.pushRoute',
            'Navigator.goTo',
            'Navigator.open',
          ],
          correctIndex: 0,
          explanation: 'Nama rute didaftarkan di properti routes pada MaterialApp, lalu dipanggil dengan Navigator.pushNamed.',
        ),
        Question(
          text: 'Kelas yang digunakan untuk mengetahui ukuran layar perangkat adalah...',
          options: ['MediaQuery', 'Theme', 'Scaffold', 'Padding'],
          correctIndex: 0,
        ),
        Question(
          text: 'Widget yang memberikan batas ukuran (constraints) dari parent sehingga tampilan bisa berubah sesuai lebar yang tersedia adalah...',
          options: ['LayoutBuilder', 'SizedBox', 'Center', 'Align'],
          correctIndex: 0,
        ),
        Question(
          text: 'Pada package provider, method yang dipanggil untuk memberi tahu widget bahwa data berubah adalah...',
          options: [
            'setState()',
            'notifyListeners()',
            'refresh()',
            'rebuild()',
          ],
          correctIndex: 1,
          explanation: 'Kelas turunan ChangeNotifier memanggil notifyListeners() agar widget yang mendengarkan dibangun ulang.',
        ),
      ],
    ),
  ],
);
