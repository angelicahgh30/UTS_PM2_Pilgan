import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/quiz_category.dart';
import '../../models/quiz_chapter.dart';

const jaringanKomputer = QuizCategory(
  id: 'jaringan',
  title: 'Jaringan Komputer',
  description: 'OSI, protokol, dan IP',
  icon: Icons.lan_rounded,
  color: Color(0xFF0984E3),
  chapters: [
    QuizChapter(
      id: 'jaringan_1',
      number: 1,
      title: 'Model OSI dan TCP/IP',
      description: 'Lapisan jaringan dan protokol transport',
      questions: [
        Question(
          text: 'Jumlah layer pada model OSI adalah...',
          options: ['4', '5', '7', '9'],
          correctIndex: 2,
          explanation: 'Physical, Data Link, Network, Transport, Session, Presentation, Application.',
        ),
        Question(
          text: 'Layer OSI yang menangani pengalamatan fisik (MAC address) adalah...',
          options: [
            'Physical Layer',
            'Data Link Layer',
            'Network Layer',
            'Transport Layer',
          ],
          correctIndex: 1,
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
        Question(
          text: 'Protokol transport yang bersifat connection-oriented dan andal adalah...',
          options: ['UDP', 'TCP', 'IP', 'ICMP'],
          correctIndex: 1,
          explanation: 'TCP menjamin data sampai dan berurutan, UDP tidak.',
        ),
        Question(
          text: 'Jumlah layer pada model TCP/IP (versi 4 layer) adalah...',
          options: ['3', '4', '5', '7'],
          correctIndex: 1,
          explanation: 'Network Access, Internet, Transport, dan Application.',
        ),
      ],
    ),
    QuizChapter(
      id: 'jaringan_2',
      number: 2,
      title: 'Pengalamatan IP',
      description: 'IPv4, kelas IP, dan subnet',
      questions: [
        Question(
          text: 'Panjang alamat IPv4 adalah...',
          options: ['16 bit', '32 bit', '64 bit', '128 bit'],
          correctIndex: 1,
          explanation: 'IPv4 berukuran 32 bit, sedangkan IPv6 128 bit.',
        ),
        Question(
          text: 'Alamat IP 192.168.1.10 termasuk ke dalam kelas...',
          options: ['A', 'B', 'C', 'D'],
          correctIndex: 2,
          explanation: 'Kelas C memiliki oktet pertama 192 sampai 223.',
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
          text: 'Jumlah host yang dapat dipakai pada subnet /24 adalah...',
          options: ['256', '255', '254', '128'],
          correctIndex: 2,
          explanation: '2^8 = 256 alamat, dikurangi alamat network dan broadcast menjadi 254.',
        ),
        Question(
          text: 'Alamat 127.0.0.1 yang merujuk ke komputer itu sendiri disebut...',
          options: ['Gateway', 'Broadcast', 'Loopback', 'Multicast'],
          correctIndex: 2,
        ),
      ],
    ),
    QuizChapter(
      id: 'jaringan_3',
      number: 3,
      title: 'Protokol, Perangkat, dan Topologi',
      description: 'DNS, DHCP, router, dan bentuk jaringan',
      questions: [
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
          text: 'Topologi jaringan di mana semua perangkat terhubung ke satu titik pusat adalah...',
          options: ['Bus', 'Ring', 'Star', 'Mesh'],
          correctIndex: 2,
        ),
      ],
    ),
  ],
);
