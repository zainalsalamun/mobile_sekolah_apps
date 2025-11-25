Mobile Sekolah App (Flutter + GetX)

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![GetX](https://img.shields.io/badge/GetX-State%20Management-purple)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![UI](https://img.shields.io/badge/UI-Premium-blue)
![Status](https://img.shields.io/badge/Status-Development-yellow)

Aplikasi mobile modern untuk **Siswa** dan **Guru**, dibangun dengan **Flutter + GetX**, berfokus pada UI premium, navigasi cepat, dan modul lengkap untuk kegiatan sekolah.

---

# 🖼 Screenshot UI (Premium)

## **📱 Dashboard Siswa (Final Premium Design)**
![Dashboard Siswa](/mnt/data/A_2D_digital_screenshot_of_a_student_dashboard_app.png)

## **📱 Dashboard Guru (Preview Premium Style)**
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

# 🏗 Arsitektur Aplikasi

Menggunakan pola **GetX Architecture**:

lib/
┣ core/
│ ┣ bindings/
│ ┣ config/
│ ┣ routes/
│ ┣ widgets/
│ ┗ services/
┣ modules/
│ ┣ auth/
│ ┣ dashboard_siswa/
│ ┣ dashboard_guru/
│ ┣ absensi/
│ ┣ jadwal/
│ ┣ nilai/
│ ┗ pengumuman/
┗ main.dart

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

