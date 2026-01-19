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

---
Developed with ❤️ for the cinematic experience.
