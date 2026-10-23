# Kuisin

Aplikasi kuis pilihan ganda untuk latihan materi Ilmu Komputer. Dibuat untuk UTS Lab Pemrograman Mobile, Semester Ganjil 2026/2027.

## Identitas Mahasiswa

- Nama: Angelica Happy Grace Harianja
- NIM: 241401130
- Lab: Lab 2 Pemrograman Mobile

## Informasi Aplikasi

### Nama Aplikasi

Kuisin

### Deskripsi Singkat

Kuisin adalah aplikasi latihan soal pilihan ganda. Pengguna memasukkan nama, memilih materi, memilih bab, lalu menjawab 5 soal dengan batas waktu per soal. Setiap jawaban langsung dinilai beserta pembahasannya, dan di akhir kuis pengguna melihat skor akhir atas namanya sendiri. Semua hasil tersimpan di riwayat.

Seluruh data (soal, nama pengguna, riwayat) disimpan lokal di memori aplikasi, tanpa database.

### Fitur

- Halaman sambutan dengan ilustrasi dan ringkasan fitur.
- Halaman isi nama dengan validasi (wajib diisi, minimal 3 huruf, hanya huruf).
- 4 materi: Pemrograman Mobile, Basis Data, Jaringan Komputer, serta Organisasi dan Arsitektur Komputer.
- Setiap materi dibagi menjadi 3 bab, dan setiap bab berisi 5 soal (total 12 bab dan 60 soal). Contohnya, Pemrograman Mobile terdiri dari Bab 1 Dasar Flutter dan Dart, Bab 2 Widget dan Layout, serta Bab 3 Navigasi, Responsif, dan State.
- Halaman daftar bab per materi: progres bab yang sudah selesai, jumlah soal per bab, dan nilai terbaik tiap bab.
- Halaman detail bab sebelum kuis dimulai: jumlah soal, waktu per soal, cara bermain, dan nilai terbaik sebelumnya.
- Timer 30 detik per soal. Jika waktu habis, soal dianggap salah.
- Feedback langsung setelah menjawab: jawaban benar dan salah ditandai, lengkap dengan kunci jawaban dan penjelasannya.
- Combo untuk jawaban benar berturut-turut, dan rekornya tercatat.
- Progres kuis tidak hilang saat layar dirotasi atau keluar ke beranda. Kuis bisa dilanjutkan lewat kartu "Lanjutkan kuis" di beranda, dan timer berhenti selama pengguna keluar.
- Halaman hasil: skor 0 sampai 100 dengan nama pengguna, jumlah benar, salah, dan waktu habis, combo terbaik, serta durasi.
- Halaman pembahasan semua soal, dengan filter Semua, Benar, dan Salah.
- Beranda: sapaan sesuai waktu, progres bab yang sudah selesai, jumlah kuis selesai, rata-rata nilai, dan rekor combo.
- Riwayat: rata-rata nilai, jumlah bab selesai, progres dan nilai per materi, serta daftar kuis terakhir (beserta babnya) yang bisa dibuka lagi pembahasannya.
- Profil: nama pengguna, ringkasan nilai, pengaturan mode gelap, dan tombol keluar.
- Mode terang dan gelap (bonus).
- Tampilan responsive dan adaptive untuk HP, tablet, dan web (bonus). Di HP memakai navigasi bawah, sedangkan di tablet dan web memakai navigasi samping dan tata letak dua kolom.

## Pemenuhan Kriteria

1. StatelessWidget dan StatefulWidget: StatefulWidget dipakai di LoginScreen, QuizScreen, ReviewScreen, MainShell, dan AppTextField. Halaman dan widget lainnya memakai StatelessWidget.
2. Minimal 2 halaman dan navigasi: Sambutan, Isi nama, Beranda, Riwayat, Profil, Daftar bab, Detail bab, Kuis, Hasil, dan Pembahasan. Navigasi memakai named routes di lib/routes/app_routes.dart.
3. Reusable widget: semua widget yang dipakai berulang ada di folder lib/widgets, satu widget per file.
4. Aset gambar dan ikon: ilustrasi SVG di assets/images dan Material Icons.
5. Font kustom: Plus Jakarta Sans di assets/fonts.
6. Ukuran dinamis: ukuran elemen dihitung dari ukuran layar lewat lib/core/utils/responsive.dart.
7. State management: memakai provider (AuthProvider, QuizProvider, HistoryProvider, ThemeProvider), sehingga progres tidak hilang saat layar dirotasi atau berpindah halaman.
8. Tanpa database: soal disimpan per materi di lib/data/materi (satu file per materi, berisi semua bab dan soalnya), lalu dikumpulkan di lib/data/quiz_data.dart. Nama pengguna dan riwayat disimpan di memori.

## Dokumentasi

### Credit Aset

- Font Plus Jakarta Sans oleh Tokotype (https://github.com/tokotype/PlusJakartaSans), lisensi SIL Open Font License 1.1.
- Ikon dari Material Icons (https://fonts.google.com/icons), lisensi Apache 2.0.
- Ilustrasi logo, welcome, trophy, dan empty dibuat sendiri untuk proyek ini.
- Package: provider, flutter_svg, dan fake_async (untuk test).

### Screenshot

Sambutan

![Sambutan](docs/screenshots/01-sambutan.png)

Isi nama

![Isi nama](docs/screenshots/02-nama.png)

Beranda

![Beranda](docs/screenshots/03-beranda.png)

Daftar bab

![Daftar bab](docs/screenshots/04-daftar-bab.png)

Detail bab

![Detail bab](docs/screenshots/05-detail-bab.png)

Kuis

![Kuis](docs/screenshots/06-kuis.png)

Feedback jawaban benar

![Feedback jawaban benar](docs/screenshots/07-feedback-benar.png)

Feedback jawaban salah

![Feedback jawaban salah](docs/screenshots/08-feedback-salah.png)

Hasil

![Hasil](docs/screenshots/09-hasil.png)

Pembahasan

![Pembahasan](docs/screenshots/10-pembahasan.png)

Riwayat

![Riwayat](docs/screenshots/11-riwayat.png)

Profil

![Profil](docs/screenshots/12-profil.png)

### Mockup / Prototype
Link : https://www.figma.com/design/Hcoz0v2agfsMpG1tQTwGQE/Prototype-Kuisin?node-id=0-1&t=2qOuk9Rh1hbKXGKy-1
