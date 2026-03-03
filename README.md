# CineFlow 🎬

CineFlow is a premium, modern movie explorer application built with Flutter. It showcases high-fidelity UI/UX, smooth animations, and a clean architecture approach, designed to provide a cinematic experience for movie enthusiasts.

## ✨ Features

- **Cinematic UI/UX**: Sophisticated design with full support for Dark and Light themes.
- **Sliver-based Scrolling**: A premium home screen experience with collapsing headers and featured content.
- **Hero Animations**: Seamless transitions between the movie grid and detail screens.
- **Offline-First**: Local caching via Hive ensures you can browse previously fetched movies even without an internet connection.
- **Favorites**: Save your favorite movies locally to build your personal watchlist.
- **Search**: Real-time movie searching and discovery.
- **Responsive**: Dynamic grid layout that adapts perfectly from mobile to web/desktop screens.

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (latest stable)
- **State Management**: [Riverpod](https://riverpod.dev/) (Modern code-generation approach)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking**: [Dio](https://pub.dev/packages/dio) & [tmdb_api](https://pub.dev/packages/tmdb_api)
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Local Persistence**: [Hive](https://pub.dev/packages/hive)
- **Typography**: [Google Fonts (Outfit)](https://fonts.google.com/specimen/Outfit)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- A TMDB API Key (optional for basic structure, required for real data)

## 🏛 Architecture

The project follows **Clean Architecture** principles, organized by features:

```text
lib/
├── core/            # Shared logic, theme, navigation, storage
└── features/
    ├── movies/      # Movie discovery and details
    ├── search/      # Search functionality
    └── favorites/   # User's personal watchlist
```

## 🧪 Testing

This project includes unit tests for core entities and repositories using `flutter_test` and `mocktail`.

To run all unit tests, execute the following command in the root of the project:

```bash
flutter test
```

Or with expanded output:

```bash
flutter test --reporter expanded
```

To run a specific test file:

```bash
flutter test test/features/movies/domain/entities/movie_test.dart
```

## 🖼️ Widget Testing

This project also includes widget tests for the visual presentation components using `network_image_mock`.

To run widget tests exclusively or specific files:

```bash
flutter test test/features/movies/presentation/widgets/movie_card_test.dart
```

## 🚗 Integration Testing

This project includes end-to-end integration tests using `integration_test` that run directly on emulators, devices, and browsers.

### Running on Mobile (iOS / Android)

Run this command with a booted emulator or connected device:

```bash
flutter test integration_test/app_test.dart
```

### Running on Web (Chromedriver)

To run integration tests on Chrome, you need to install and use `chromedriver` and the Flutter driver. 

1. Start `chromedriver` on port 4444 in the background:
```bash
chromedriver --port=4444
```

2. Open another terminal and run the test using `flutter drive`:
```bash
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d web-server \
  --browser-name=chrome
```
