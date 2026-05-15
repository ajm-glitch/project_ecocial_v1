# Ecocial

**A social media mobile app that inspires everyday eco-friendly actions.**

Ecocial is a community-driven platform where users share and discover small, impactful sustainability habits — making eco-conscious living social, accessible, and fun. Built entirely self-taught using Flutter, Dart, and Firebase, the app was successfully launched on the App Store and won the **Department Award for Computer Science Capstone** at Gunn High School, Palo Alto, CA.

---

## Features

- **Eco-action feed** — browse and share posts of everyday sustainable actions
- **User authentication** — sign in with email/password, Google, or Apple
- **Image posts** — pick and upload photos via Firebase Storage
- **Real-time data** — Cloud Firestore and Firebase Realtime Database keep content live and in sync
- **User profiles** — personalized accounts with persistent preferences
- **Social interactions** — follow others and engage with their eco-actions
- **Cross-platform** — runs on both iOS and Android

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev/) (Dart) |
| Backend / Auth | [Firebase Authentication](https://firebase.google.com/products/auth) |
| Database | [Cloud Firestore](https://firebase.google.com/products/firestore) + [Firebase Realtime Database](https://firebase.google.com/products/realtime-database) |
| Storage | [Firebase Storage](https://firebase.google.com/products/storage) |
| State Management | [Provider](https://pub.dev/packages/provider) + [GetX](https://pub.dev/packages/get) |
| Auth Providers | Google Sign-In, Sign in with Apple |
| UI | Material Design, Font Awesome icons, OpenSans font |

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK `>=2.12.0 <3.0.0`)
- A Firebase project with Authentication, Firestore, Realtime Database, and Storage enabled
- Xcode (for iOS) or Android Studio (for Android)

### Installation

```bash
# Clone the repository
git clone https://github.com/ajm-glitch/project_ecocial_v1.git
cd project_ecocial_v1

# Install dependencies
flutter pub get
```

### Firebase Setup

1. Create a project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Authentication** (Email/Password, Google, Apple)
3. Create a **Firestore** database and **Realtime Database**
4. Enable **Firebase Storage**
5. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and place them in the respective platform directories
6. (Optional) Configure Sign in with Apple in your Apple Developer account

### Run the App

```bash
flutter run
```

---

## Project Structure

```
lib/              # Main Dart source code
assets/           # Images and other static assets
fonts/OpenSans/   # Custom font files
android/          # Android platform config
ios/              # iOS platform config
test/             # Unit and widget tests
```

---

## Version

Current version: **1.3.0** (build 11)

---

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).

---

## About

Created by **Anjani Mirchandani** ([@ajm-glitch](https://github.com/ajm-glitch)) as a solo project from conception to launch, self-teaching Flutter, Dart, and Firebase along the way.
