import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/quiz_category.dart';
import '../../models/quiz_chapter.dart';

const basisData = QuizCategory(
  id: 'basis_data',
  title: 'Basis Data',
  description: 'SQL, relasi, dan normalisasi',
  icon: Icons.storage_rounded,
  color: Color(0xFF00B894),
  chapters: [
    QuizChapter(
      id: 'basis_data_1',
      number: 1,
      title: 'Konsep Dasar Basis Data',
      description: 'DBMS, ERD, dan jenis-jenis kunci',
      questions: [
        Question(
          text: 'Kepanjangan dari DBMS adalah...',
          options: [
            'Data Base Mapping System',
            'Database Management System',
            'Digital Base Management Software',
            'Data Binary Management System',
          ],
          correctIndex: 1,
        ),
        Question(
          text: 'Diagram yang digunakan untuk memodelkan entitas dan relasi antar data adalah...',
          options: ['DFD', 'ERD', 'Flowchart', 'Sequence Diagram'],
          correctIndex: 1,
          explanation: 'ERD adalah singkatan dari Entity Relationship Diagram.',
        ),
        Question(
          text: 'Atribut yang mengidentifikasi setiap baris dalam tabel secara unik disebut...',
          options: [
            'Foreign Key',
            'Primary Key',
            'Candidate Index',
            'Composite Field',
          ],
          correctIndex: 1,
          explanation:
              'Primary Key bernilai unik dan tidak boleh kosong (NOT NULL).',
        ),
        Question(
          text: 'Kunci yang merujuk ke primary key pada tabel lain disebut...',
          options: ['Primary Key', 'Super Key', 'Foreign Key', 'Alternate Key'],
          correctIndex: 2,
          explanation:
              'Foreign Key digunakan untuk membentuk relasi antar tabel.',
        ),
        Question(
          text: 'Contoh DBMS yang tergolong NoSQL adalah...',
          options: ['MySQL', 'PostgreSQL', 'MongoDB', 'Oracle Database'],
          correctIndex: 2,
        ),
      ],
    ),
    QuizChapter(
      id: 'basis_data_2',
      number: 2,
      title: 'Bahasa SQL',
      description: 'DDL, DML, filter, dan fungsi agregat',
      questions: [
        Question(
          text: 'Perintah SQL untuk mengambil data dari tabel adalah...',
          options: ['INSERT', 'UPDATE', 'SELECT', 'DELETE'],
          correctIndex: 2,
        ),
        Question(
          text: 'Perintah SQL untuk mengubah data yang sudah ada di dalam tabel adalah...',
          options: ['ALTER', 'UPDATE', 'CHANGE', 'MODIFY'],
          correctIndex: 1,
          explanation: 'UPDATE mengubah isi data, sedangkan ALTER mengubah struktur tabel.',
        ),
        Question(
          text: 'Klausa SQL untuk menyaring baris berdasarkan kondisi tertentu (sebelum pengelompokan) adalah...',
          options: ['ORDER BY', 'GROUP BY', 'WHERE', 'HAVING'],
          correctIndex: 2,
          explanation: 'WHERE menyaring baris, sedangkan HAVING menyaring hasil GROUP BY.',
        ),
        Question(
          text: 'Perintah berikut yang termasuk DDL (Data Definition Language) adalah...',
          options: ['SELECT', 'INSERT', 'CREATE TABLE', 'UPDATE'],
          correctIndex: 2,
          explanation:
              'DDL mendefinisikan struktur, misalnya CREATE, ALTER, dan DROP.',
        ),
        Question(
          text: 'Fungsi agregat untuk menghitung jumlah baris adalah...',
          options: ['SUM()', 'COUNT()', 'AVG()', 'MAX()'],
          correctIndex: 1,
          explanation: 'COUNT() menghitung jumlah baris, sedangkan SUM() menjumlahkan nilai.',
        ),
      ],
    ),
    QuizChapter(
      id: 'basis_data_3',
      number: 3,
      title: 'Normalisasi dan Transaksi',
      description: 'Bentuk normal dan sifat ACID',
      questions: [
        Question(
          text: 'Proses memecah tabel untuk mengurangi redundansi data disebut...',
          options: ['Normalisasi', 'Denormalisasi', 'Indexing', 'Replikasi'],
          correctIndex: 0,
        ),
        Question(
          text: 'Syarat utama sebuah tabel memenuhi bentuk normal pertama (1NF) adalah...',
          options: [
            'Setiap atribut bernilai atomik (tidak berulang)',
            'Tidak ada ketergantungan transitif',
            'Semua tabel memiliki foreign key',
            'Tabel hanya memiliki satu kolom',
          ],
          correctIndex: 0,
        ),
        Question(
          text: 'Bentuk normal kedua (2NF) menghilangkan...',
          options: [
            'Atribut bernilai ganda',
            'Ketergantungan parsial terhadap primary key',
            'Seluruh foreign key',
            'Data yang bernilai NULL',
          ],
          correctIndex: 1,
          explanation: 'Pada 2NF, setiap atribut non-kunci harus bergantung pada seluruh primary key, bukan sebagian.',
        ),
        Question(
          text: 'Huruf "A" pada sifat transaksi ACID adalah singkatan dari...',
          options: ['Availability', 'Atomicity', 'Accuracy', 'Authentication'],
          correctIndex: 1,
          explanation: 'ACID: Atomicity, Consistency, Isolation, Durability.',
        ),
        Question(
          text: 'Perintah untuk menyimpan perubahan transaksi secara permanen adalah...',
          options: ['SAVE', 'ROLLBACK', 'COMMIT', 'END'],
          correctIndex: 2,
          explanation:
              'COMMIT menyimpan perubahan, sedangkan ROLLBACK membatalkannya.',
        ),
      ],
    ),
  ],
);
