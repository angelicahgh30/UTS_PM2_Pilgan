import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/quiz_category.dart';
import '../../models/quiz_chapter.dart';

const arsitekturKomputer = QuizCategory(
  id: 'oak',
  title: 'Organisasi & Arsitektur Komputer',
  description: 'CPU, memori, dan instruksi',
  icon: Icons.memory_rounded,
  color: Color(0xFFE17055),
  chapters: [
    QuizChapter(
      id: 'oak_1',
      number: 1,
      title: 'Komponen CPU',
      description: 'ALU, Control Unit, register, dan siklus instruksi',
      questions: [
        Question(
          text: 'Komponen CPU yang melakukan operasi aritmatika dan logika adalah...',
          options: ['Control Unit', 'ALU', 'Register', 'Cache'],
          correctIndex: 1,
          explanation: 'ALU adalah singkatan dari Arithmetic Logic Unit.',
        ),
        Question(
          text: 'Komponen CPU yang mengatur dan mengendalikan jalannya eksekusi instruksi adalah...',
          options: ['ALU', 'Control Unit', 'Cache', 'Bus'],
          correctIndex: 1,
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
          text: 'Satuan yang digunakan untuk kecepatan clock CPU adalah...',
          options: ['Byte', 'Hertz', 'Watt', 'bps'],
          correctIndex: 1,
          explanation:
              'Kecepatan clock biasanya ditulis dalam GHz, misalnya 3,2 GHz.',
        ),
      ],
    ),
    QuizChapter(
      id: 'oak_2',
      number: 2,
      title: 'Memori dan Bus',
      description: 'Hierarki memori dan jalur data',
      questions: [
        Question(
          text: 'Memori dengan akses paling cepat dalam hierarki memori adalah...',
          options: ['RAM', 'Cache L3', 'Register', 'SSD'],
          correctIndex: 2,
          explanation: 'Register berada di dalam CPU sehingga paling cepat, tetapi kapasitasnya paling kecil.',
        ),
        Question(
          text: 'Memori kecil berkecepatan tinggi yang berada di antara CPU dan RAM adalah...',
          options: ['ROM', 'Cache', 'Virtual Memory', 'Hard Disk'],
          correctIndex: 1,
        ),
        Question(
          text: 'Memori yang datanya hilang ketika komputer dimatikan (volatile) adalah...',
          options: ['ROM', 'RAM', 'Flash Memory', 'Hard Disk'],
          correctIndex: 1,
        ),
        Question(
          text: 'Jalur bus yang membawa alamat lokasi memori adalah...',
          options: ['Data Bus', 'Address Bus', 'Control Bus', 'USB'],
          correctIndex: 1,
        ),
        Question(
          text: '1 byte sama dengan...',
          options: ['4 bit', '8 bit', '16 bit', '32 bit'],
          correctIndex: 1,
        ),
      ],
    ),
    QuizChapter(
      id: 'oak_3',
      number: 3,
      title: 'Arsitektur dan Instruksi',
      description: 'Von Neumann, Harvard, RISC, dan pipelining',
      questions: [
        Question(
          text: 'Arsitektur komputer yang menyimpan program dan data pada memori yang sama adalah...',
          options: ['Harvard', 'Von Neumann', 'RISC', 'Pipeline'],
          correctIndex: 1,
        ),
        Question(
          text: 'Arsitektur yang memisahkan memori untuk instruksi dan memori untuk data adalah...',
          options: ['Von Neumann', 'Harvard', 'CISC', 'Superscalar'],
          correctIndex: 1,
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
          text: 'Contoh prosesor yang menggunakan arsitektur RISC adalah...',
          options: [
            'Intel Core i7',
            'AMD Ryzen',
            'ARM Cortex',
            'Intel Pentium',
          ],
          correctIndex: 2,
          explanation: 'Prosesor ARM banyak dipakai di HP karena hemat daya. Intel dan AMD memakai x86 (CISC).',
        ),
        Question(
          text: 'Teknik menjalankan tahapan beberapa instruksi secara tumpang tindih disebut...',
          options: ['Paging', 'Pipelining', 'Caching', 'Interrupt'],
          correctIndex: 1,
          explanation:
              'Pipelining meningkatkan throughput CPU seperti lini perakitan.',
        ),
      ],
    ),
  ],
);
