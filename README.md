Mobile Sekolah App (Flutter + GetX)

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![GetX](https://img.shields.io/badge/GetX-State%20Management-purple)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![UI](https://img.shields.io/badge/UI-Premium-blue)
![Status](https://img.shields.io/badge/Status-Development-yellow)

Aplikasi mobile modern untuk **Siswa** dan **Guru**, dibangun dengan **Flutter + GetX**, berfokus pada UI premium, navigasi cepat, dan modul lengkap untuk kegiatan sekolah.

---

# 🖼 Screenshot UI

## **📱 Dashboard Siswa **
![Dashboard Siswa](/mnt/data/A_2D_digital_screenshot_of_a_student_dashboard_app.png)

## **📱 Dashboard Guru **
![Dashboard Guru](/mnt/data/A_digital_screenshot_displays_a_student_dashboard_.png)

---

# 🧩 Fitur Aplikasi

## 👨‍🎓 **Fitur untuk Siswa**
- Dashboard premium (gradient + avatar + notifikasi)
- Statistik nilai & absensi
- Jadwal pelajaran hari ini
- Pengumuman terbaru dari sekolah
- Akses cepat ke:
  - Nilai
  - Absensi
  - Jadwal
  - Pengumuman

## 👨‍🏫 **Fitur untuk Guru**
- Dashboard premium guru (jadwal mengajar + kelas absensi)
- Input Absensi kelas
- Input Nilai siswa
- Jadwal mengajar lengkap
- Pengumuman sekolah
- Akses cepat ke modul pengajaran

---

# 🎨 Desain UI
Aplikasi memiliki tampilan UI modern:

- Gradient biru premium  
- Rounded card (radius 16–20)  
- Soft shadow  
- Icon Material modern  
- Typography bold & clean  
- Spacing ideal (16–24)  
- Komponen reusable: AppCard, AppInput, AppButton  

---

📐 Arsitektur Aplikasi 

Berikut tabel arsitektur lengkap berdasarkan struktur project Flutter kamu:

📂 Struktur Folder (Tabel Detail)
Folder / File	Deskripsi
lib/	Folder utama aplikasi Flutter
┣ core/	Menampung sistem inti aplikasi (global logic)
┃ ┣ bindings/	GetX bindings untuk dependency injection tiap module
┃ ┣ config/	Konfigurasi global (warna, tema, constants)
┃ ┣ routes/	File route GetX (AppPages & AppRoutes)
┃ ┣ services/	Layanan global: API, storage, helper dll
┃ ┗ widgets/	Widget reusable: AppCard, AppButton, AppInput
┣ modules/	Semua fitur utama aplikasi dipisah per modul
┃ ┣ auth/	Login (controller, view, binding)
┃ ┣ dashboard_siswa/	Dashboard siswa (controller, view, widgets)
┃ ┣ dashboard_guru/	Dashboard guru (controller, view, widgets)
┃ ┣ absensi/	Modul absensi siswa/guru
┃ ┣ jadwal/	Jadwal siswa & guru
┃ ┣ nilai/	Modul nilai + detail nilai
┃ ┗ pengumuman/	Pengumuman + detail pengumuman
┗ main.dart	Entry point Flutter, mengatur initialRoute & theme

🧩 Struktur Modul (Tabel Modularization)
Nama Modul	Isi File	Fungsi
auth	controller, binding, login_view	Login siswa/guru
dashboard_siswa	controller, binding, view, widget	Dashboard utama siswa
dashboard_guru	controller, binding, view, widget	Dashboard utama guru
absensi	controller, view, binding	Input & rekap absensi
jadwal	controller, view, binding	Jadwal pelajaran & mengajar
nilai	controller, view, binding	Nilai siswa & detail nilai
pengumuman	controller, view, detail_view, binding	Pengumuman sekolah
⚙ Komponen Inti (Core Layer Table)
Komponen	File	Fungsi
Theme System	app_theme.dart, app_colors.dart	Warna global, typography
Route Manager	app_pages.dart, app_routes.dart	Navigasi GetX
Widgets Reusable	AppCard, AppInput, AppButton, dll	Menjaga UI konsisten
Bindings Global	InitialBinding()	Dependency awal
Service Layer (Opsional)	api_service.dart	Call API ke backend

🧠 GetX Architecture (Tabel UML Simplified)
Layer	Isi	Deskripsi
View	.dart file (UI)	Menampilkan tampilan UI (Stateless/Stateful)
Controller	xx_controller.dart	Mengatur state, logic, API call
Binding	xx_binding.dart	Inject controller saat route dibuka
Route	AppPages, AppRoutes	Pendefinisian path halaman
Service	API, storage, helper	Fungsi backend atau utility

yaml
Copy code

---

# 🔗 Routing (GetX Pages)

| Route | Halaman |
|-------|---------|
| `/` | Splash |
| `/login` | LoginView |
| `/dashboard-siswa` | Dashboard Siswa |
| `/dashboard-guru` | Dashboard Guru |
| `/absensi` | Absensi |
| `/nilai` | Nilai |
| `/detail-nilai` | Detail Nilai |
| `/jadwal` | Jadwal Siswa |
| `/pengumuman` | Pengumuman |
| `/pengumuman-detail` | Detail Pengumuman |

---

# 🧠 Binding (Dependency Injection)

Setiap module memiliki binding:

LoginBinding()
DashboardSiswaBinding()
DashboardGuruBinding()
AbsensiBinding()
JadwalBinding()
NilaiBinding()
PengumumanBinding()

yaml
Copy code

Binding memastikan controller dibuat otomatis saat halaman diakses.

---

# 🛠 Instalasi & Menjalankan Project

## 1️⃣ Clone Repository
```bash
git clone <repo_url>
cd mobile_sekolah_app
2️⃣ Install Dependencies
bash
Copy code
flutter pub get
3️⃣ Run Aplikasi
bash
Copy code
flutter run
📦 Dependencies Utama
Tambahkan di pubspec.yaml:

yaml
Copy code
dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.3
Custom widgets (buatan internal):

AppCard

AppButton

AppInput

LoadingIndicator

🚀 Tech Stack
Flutter 3.x

Dart 3.x

GetX (Route, State, DI)

AppTheme Custom

(Opsional) Backend Node.js + Express + PostgreSQL

⚙ API Ready
Struktur data (controller) sudah siap dihubungkan ke API:

Absensi → POST

Nilai → GET/POST

Jadwal → GET

Pengumuman → GET

Auth → Login (role-based)

🧪 Testing
Jalankan unit test:

bash
Copy code
flutter test
📱 Platform Support
Android 5.0+ (SDK 21)

iOS 12+

🤝 Kontribusi
Pull request diterima dengan senang hati!
Pastikan perubahan sudah diuji sebelum membuat PR.

📄 License
MIT License – bebas digunakan untuk sekolah atau internal.

