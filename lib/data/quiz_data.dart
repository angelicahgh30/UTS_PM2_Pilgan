import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/quiz_category.dart';

const List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'mobile',
    title: 'Pemrograman Mobile',
    description: 'Flutter, Dart, dan widget',
    icon: Icons.phone_android_rounded,
    color: Color(0xFF6C5CE7),
    questions: [
      Question(
        text: 'Bahasa pemrograman yang digunakan oleh Flutter adalah...',
        options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
        correctIndex: 2,
        explanation:
            'Flutter dikembangkan oleh Google dan memakai bahasa Dart.',
      ),
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
        text: 'Widget untuk menyusun beberapa widget secara vertikal adalah...',
        options: ['Row', 'Stack', 'Column', 'Wrap'],
        correctIndex: 2,
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
        text: 'Kelas yang digunakan untuk mengetahui ukuran layar perangkat adalah...',
        options: ['MediaQuery', 'Theme', 'Scaffold', 'Padding'],
        correctIndex: 0,
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
      Question(
        text: 'Widget kerangka halaman Material yang menyediakan AppBar, body, dan FloatingActionButton adalah...',
        options: ['Container', 'Scaffold', 'MaterialApp', 'SafeArea'],
        correctIndex: 1,
      ),
    ],
  ),
  QuizCategory(
    id: 'basis_data',
    title: 'Basis Data',
    description: 'SQL, relasi, dan normalisasi',
    icon: Icons.storage_rounded,
    color: Color(0xFF00B894),
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
        text: 'Perintah SQL untuk mengambil data dari tabel adalah...',
        options: ['INSERT', 'UPDATE', 'SELECT', 'DELETE'],
        correctIndex: 2,
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
        text:
            'Proses memecah tabel untuk mengurangi redundansi data disebut...',
        options: ['Normalisasi', 'Denormalisasi', 'Indexing', 'Replikasi'],
        correctIndex: 0,
      ),
      Question(
        text: 'Klausa SQL untuk menyaring baris berdasarkan kondisi tertentu (sebelum pengelompokan) adalah...',
        options: ['ORDER BY', 'GROUP BY', 'WHERE', 'HAVING'],
        correctIndex: 2,
        explanation:
            'WHERE menyaring baris, sedangkan HAVING menyaring hasil GROUP BY.',
      ),
      Question(
        text: 'Diagram yang digunakan untuk memodelkan entitas dan relasi antar data adalah...',
        options: ['DFD', 'ERD', 'Flowchart', 'Sequence Diagram'],
        correctIndex: 1,
        explanation: 'ERD adalah singkatan dari Entity Relationship Diagram.',
      ),
      Question(
        text: 'Perintah berikut yang termasuk DDL (Data Definition Language) adalah...',
        options: ['SELECT', 'INSERT', 'CREATE TABLE', 'UPDATE'],
        correctIndex: 2,
        explanation:
            'DDL mendefinisikan struktur, misalnya CREATE, ALTER, dan DROP.',
      ),
      Question(
        text: 'Huruf "A" pada sifat transaksi ACID adalah singkatan dari...',
        options: ['Availability', 'Atomicity', 'Accuracy', 'Authentication'],
        correctIndex: 1,
        explanation: 'ACID: Atomicity, Consistency, Isolation, Durability.',
      ),
      Question(
        text: 'Contoh DBMS yang tergolong NoSQL adalah...',
        options: ['MySQL', 'PostgreSQL', 'MongoDB', 'Oracle Database'],
        correctIndex: 2,
      ),
    ],
  ),
  QuizCategory(
    id: 'jaringan',
    title: 'Jaringan Komputer',
    description: 'OSI, protokol, dan IP',
    icon: Icons.lan_rounded,
    color: Color(0xFF0984E3),
    questions: [
      Question(
        text: 'Jumlah layer pada model OSI adalah...',
        options: ['4', '5', '7', '9'],
        correctIndex: 2,
        explanation: 'Physical, Data Link, Network, Transport, Session, Presentation, Application.',
      ),
      Question(
        text: 'Protokol yang memberikan alamat IP kepada perangkat secara otomatis adalah...',
        options: ['DNS', 'DHCP', 'FTP', 'SMTP'],
        correctIndex: 1,
      ),
      Question(
        text: 'Fungsi utama DNS adalah...',
        options: [
          'Mengenkripsi data yang dikirim',
          'Menerjemahkan nama domain menjadi alamat IP',
          'Membagikan alamat IP secara otomatis',
          'Mengirim surat elektronik',
        ],
        correctIndex: 1,
      ),
      Question(
        text: 'Port default yang digunakan oleh HTTPS adalah...',
        options: ['80', '21', '443', '22'],
        correctIndex: 2,
        explanation: 'Port 80 untuk HTTP, 443 untuk HTTPS.',
      ),
      Question(
        text: 'Perangkat yang menghubungkan jaringan berbeda dan menentukan rute paket adalah...',
        options: ['Hub', 'Switch', 'Router', 'Repeater'],
        correctIndex: 2,
      ),
      Question(
        text: 'Panjang alamat IPv4 adalah...',
        options: ['16 bit', '32 bit', '64 bit', '128 bit'],
        correctIndex: 1,
        explanation: 'IPv4 berukuran 32 bit, sedangkan IPv6 128 bit.',
      ),
      Question(
        text: 'Topologi jaringan di mana semua perangkat terhubung ke satu titik pusat adalah...',
        options: ['Bus', 'Ring', 'Star', 'Mesh'],
        correctIndex: 2,
      ),
      Question(
        text: 'Protokol transport yang bersifat connection-oriented dan andal adalah...',
        options: ['UDP', 'TCP', 'IP', 'ICMP'],
        correctIndex: 1,
        explanation: 'TCP menjamin data sampai dan berurutan, UDP tidak.',
      ),
      Question(
        text: 'Subnet mask default untuk alamat IP kelas C adalah...',
        options: [
          '255.0.0.0',
          '255.255.0.0',
          '255.255.255.0',
          '255.255.255.255',
        ],
        correctIndex: 2,
      ),
      Question(
        text: 'Router bekerja pada layer OSI ke-3, yaitu...',
        options: [
          'Data Link Layer',
          'Network Layer',
          'Transport Layer',
          'Session Layer',
        ],
        correctIndex: 1,
      ),
    ],
  ),
  QuizCategory(
    id: 'oak',
    title: 'Organisasi & Arsitektur Komputer',
    description: 'CPU, memori, dan instruksi',
    icon: Icons.memory_rounded,
    color: Color(0xFFE17055),
    questions: [
      Question(
        text: 'Komponen CPU yang melakukan operasi aritmatika dan logika adalah...',
        options: ['Control Unit', 'ALU', 'Register', 'Cache'],
        correctIndex: 1,
        explanation: 'ALU adalah singkatan dari Arithmetic Logic Unit.',
      ),
      Question(
        text: 'Arsitektur komputer yang menyimpan program dan data pada memori yang sama adalah...',
        options: ['Harvard', 'Von Neumann', 'RISC', 'Pipeline'],
        correctIndex: 1,
      ),
      Question(
        text:
            'Memori dengan akses paling cepat dalam hierarki memori adalah...',
        options: ['RAM', 'Cache L3', 'Register', 'SSD'],
        correctIndex: 2,
        explanation: 'Register berada di dalam CPU sehingga paling cepat, tetapi kapasitasnya paling kecil.',
      ),
      Question(
        text: 'Register yang menyimpan alamat instruksi berikutnya yang akan dieksekusi adalah...',
        options: [
          'Program Counter',
          'Accumulator',
          'Instruction Register',
          'Stack Pointer',
        ],
        correctIndex: 0,
      ),
      Question(
        text: 'Urutan siklus dasar eksekusi instruksi oleh CPU adalah...',
        options: [
          'Fetch – Decode – Execute',
          'Input – Process – Output',
          'Load – Store – Jump',
          'Read – Write – Erase',
        ],
        correctIndex: 0,
      ),
      Question(
        text: 'Kepanjangan dari RISC adalah...',
        options: [
          'Reduced Instruction Set Computer',
          'Rapid Integrated System Computing',
          'Register Instruction Set Code',
          'Reduced Internal Storage Computer',
        ],
        correctIndex: 0,
      ),
      Question(
        text: 'Teknik menjalankan tahapan beberapa instruksi secara tumpang tindih disebut...',
        options: ['Paging', 'Pipelining', 'Caching', 'Interrupt'],
        correctIndex: 1,
        explanation:
            'Pipelining meningkatkan throughput CPU seperti lini perakitan.',
      ),
      Question(
        text: 'Jalur bus yang membawa alamat lokasi memori adalah...',
        options: ['Data Bus', 'Address Bus', 'Control Bus', 'USB'],
        correctIndex: 1,
      ),
      Question(
        text: 'Memori yang datanya hilang ketika komputer dimatikan (volatile) adalah...',
        options: ['ROM', 'RAM', 'Flash Memory', 'Hard Disk'],
        correctIndex: 1,
      ),
      Question(
        text: '1 byte sama dengan...',
        options: ['4 bit', '8 bit', '16 bit', '32 bit'],
        correctIndex: 1,
      ),
    ],
  ),
];
