Mobile Sekolah App (Flutter + GetX)
Ringkasan Proyek

Mobile Sekolah App adalah aplikasi mobile berbasis Flutter untuk Siswa dan Guru, yang menyediakan fitur:

Dashboard Siswa

Dashboard Guru

Absensi

Jadwal

Nilai

Pengumuman

Login (Role: siswa/guru)

UI Premium Modern (gradient, card, quick actions)

Aplikasi ini menggunakan Flutter + GetX untuk state management, route, dan dependency injection.

🏗 Tech Stack
Layer	Teknologi
Frontend	Flutter 3.x
State Management	GetX
Route	GetX Navigation
Dependency Injection	GetX Bindings
Style	Custom AppTheme
API	(Opsional) Node.js + Express + PostgreSQL
Device	Android & iOS
📂 Struktur Folder
lib/
 ┣ core/
 │ ┣ bindings/
 │ ┣ routes/
 │ ┣ widgets/
 │ ┣ services/
 │ ┗ config/
 ┣ modules/
 │ ┣ auth/
 │ ┣ dashboard_siswa/
 │ ┣ dashboard_guru/
 │ ┣ absensi/
 │ ┣ jadwal/
 │ ┣ nilai/
 │ ┗ pengumuman/
 ┗ main.dart

🚀 Fitur Utama
👨‍🎓 Fitur untuk Siswa

Dashboard premium (gradient + statistik)

Jadwal hari ini

Nilai rata-rata

Absensi hari ini

Pengumuman terbaru

👨‍🏫 Fitur untuk Guru

Dashboard premium guru

Jadwal mengajar hari ini

Kelas yang harus diabsen

Input Absensi

Pengumuman dari sekolah

🔐 Auth (Siswa & Guru)

Login dengan role

Routing otomatis berdasarkan role

📣 Pengumuman

Card premium dengan icon megaphone

Halaman detail pengumuman

🎨 Desain UI

Aplikasi menggunakan desain:

Gradient premium biru

Rounded card

Icon modern (Material Icons)

Shadow lembut

Padding 16 / 18 untuk spacing ideal

Typography clean (700/600/400)

Contoh mockup (preview disimpan oleh user):

➡️ /mnt/data/A_2D_digital_screenshot_of_a_student_dashboard_app.png

🧩 Dependencies Penting

Tambahkan pada pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.3


Custom widgets:

AppCard

AppInput

AppButton

LoadingIndicator

🛠 Cara Menjalankan Proyek
1. Clone Repository
git clone <repo_url>
cd mobile_sekolah_app

2. Install Dependencies
flutter pub get

3. Jalankan Aplikasi
flutter run

🔗 Navigasi (GetX Routes)
Route	Halaman
/	Splash
/login	LoginView
/dashboard-siswa	Dashboard Siswa
/dashboard-guru	Dashboard Guru
/nilai	NilaiView
/detail-nilai	Detail Nilai
/absensi	AbsensiView
/jadwal	JadwalView
/pengumuman	PengumumanView
/pengumuman-detail	Detail Pengumuman
🧠 Binding System (GetX)

Semua module memiliki binding:

LoginBinding()

DashboardSiswaBinding()

DashboardGuruBinding()

AbsensiBinding()

JadwalBinding()

NilaiBinding()

PengumumanBinding()

🏛 Arsitektur

Aplikasi ini mengikuti pola:

MVx (Model-View-Controller) dengan GetX

Setiap fitur punya:

Controller

View

Binding

Model (opsional)

🧪 Testing

Jalankan:

flutter test

🛡 Environment

Support:

Android API 21+

iOS 12+

Flutter 3.x

📌 Catatan Developer

Gunakan Obx() untuk reactiveness ringan.

Jangan lupa register route di AppPages.

Sesuaikan warna dengan AppColors.

📄 License

MIT License – bebas dipakai untuk kebutuhan sekolah / internal.
