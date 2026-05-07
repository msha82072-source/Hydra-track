HydraTrack is a premium, high-performance hydration tracking application designed to help users maintain optimal health through personalized water intake monitoring. Built with a focus on **Visual Excellence** and **Scalable Architecture**, it offers a seamless experience across mobile platforms.

---

## 📱 Screenshots & Demo

<div align="center">
  <table>
    <tr>
      <td><img src="https://via.placeholder.com/200x400?text=Dashboard+Light" width="200" alt="Dashboard Light"></td>
      <td><img src="https://via.placeholder.com/200x400?text=Analytics+Dark" width="200" alt="Analytics Dark"></td>
      <td><img src="https://via.placeholder.com/200x400?text=Reminders+Black" width="200" alt="Reminders Black"></td>
    </tr>
    <tr>
      <td align="center"><b>Light Mode</b></td>
      <td align="center"><b>Dark Mode</b></td>
      <td align="center"><b>Amoled Black</b></td>
    </tr>
  </table>
  <br>
  <img src="https://via.placeholder.com/600x300?text=Feature+Highlight+Banner" width="600" alt="Feature Banner">
</div>

---

## ✨ Features

- 💧 **Smart Water Tracking** – Effortlessly log your daily water intake with a single tap.
- 🎯 **Daily Goals** – Personalized hydration targets based on user metrics.
- 🔔 **Smart Reminders** – Context-aware notifications to keep you hydrated throughout the day.
- 🥤 **Cup Customization** – Quick-select from various predefined cup sizes or create your own.
- 📊 **Progress Analytics** – Detailed visual insights into your daily and weekly hydration trends.
- 🎨 **Dynamic Theming** – Seamless support for Light, Dark, and deep Amoled Black modes.
- 📱 **Responsive UI** – Pixel-perfect layouts that adapt to any screen size.
- 🎬 **Premium Animations** – Smooth, micro-interactions powered by `flutter_animate`.

---

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev)
- **Language:** [Dart](https://dart.dev)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Local Storage:** [GetStorage](https://pub.dev/packages/get_storage)
- **Visuals:** [Google Fonts](https://pub.dev/packages/google_fonts), [FontAwesome](https://pub.dev/packages/font_awesome_flutter)
- **Animations:** [Flutter Animate](https://pub.dev/packages/flutter_animate)

---

## 🏗️ Architecture Overview

The project follows a **Clean MVVM (Model-View-ViewModel)** architecture, ensuring a strict separation of concerns, high testability, and easy maintainability.

- **Model:** Represents the data layer and business logic (Entities).
- **View:** Pure UI components (Stateless/Stateful widgets) that react to data changes.
- **ViewModel (Controller):** Powered by GetX Controllers, handling business logic and state updates.

### 📂 Folder Structure

```text
lib/
├── core/               # Global configurations & utilities
│   ├── theme/          # Custom Dynamic Theme System (Light/Dark/Black)
│   ├── utils/          # Date formatters, validators, and helpers
│   └── values/         # Static assets, colors, and string constants
├── data/               # Data Layer
│   ├── models/         # Data blueprints (WaterIntake, Reminder, Cup)
│   ├── providers/      # Local/Remote data sources (GetStorage)
│   └── repositories/   # Abstracted data access logic
├── presentation/       # UI Layer (MVVM)
│   ├── modules/        # Feature-based folders
│   │   ├── dashboard/  # Dashboard View & Controller
│   │   ├── progress/   # Analytics & Charts
│   │   └── settings/   # App configuration logic
│   └── widgets/        # Reusable UI components
└── main.dart           # Dependency Injection & App Entry
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.11.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/hydra_track.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd hydra_track
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   # For Debug mode
   flutter run

   # For Release mode
   flutter run --release
   ```

---

## 💡 Engineering Highlights

### ⚡ Clean Code Implementation
The codebase emphasizes readability and DRY (Don't Repeat Yourself) principles. All business logic is encapsulated within Controllers, keeping the View layer strictly for presentation.

### 📱 Responsive Design
Utilizing a custom responsiveness mixin and flexible widgets, the app ensures a consistent "App-like" feel on everything from small iPhones to large Android tablets.

### 🌑 Theme System
A robust theme engine that supports three distinct modes. The **Amoled Black** mode is specifically optimized for OLED screens to maximize battery efficiency and visual comfort.

---

## ✍️ Author

**Shahbaz Farooqui**
- GitHub: [@msha82072-source](https://github.com/msha82072-source)

