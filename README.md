# 🎬 Movie Store

> iOS application to explore movies, TV shows, and actors — built to demonstrate production-level architecture and clean code practices.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue?logo=apple)
![Architecture](https://img.shields.io/badge/Architecture-VIPER-purple)
![Tests](https://img.shields.io/badge/Tests-Unit%20%26%20UI-green)
![CocoaPods](https://img.shields.io/badge/Dependency%20Manager-CocoaPods-red)

---

## 📱 Overview

**Movie Store** is a fully functional iOS app that lets users browse and discover movies, TV shows, and actors using a public REST API. The project was built with a focus on **clean architecture**, **testability**, and **scalable UI patterns** — reflecting real-world production standards.

---

## ✨ Features

- 🔍 Search movies, TV shows, and actors
- 🎬 Browse popular, top-rated, and upcoming content
- 👤 View detailed actor profiles and filmographies
- 📄 Movie and show detail screens with synopsis, ratings, and metadata
- ⚡ Asynchronous data loading with smooth UX
- 🧪 Unit tested modules for reliability

---

## 🏗️ Architecture

This project follows the **VIPER** architectural pattern, ensuring a clear separation of concerns across all layers:

```
├── View        → UIKit components (Programmatic UI + UICollectionView)
├── Interactor  → Business logic and API data handling
├── Presenter   → Mediates between View and Interactor
├── Entity      → Data models (Codable structs)
└── Router      → Navigation and module assembly
```

Each module is independently testable and follows **SOLID principles** and **Clean Code** conventions.

---

## 🛠️ Tech Stack

| Category | Technologies |
|---|---|
| Language | Swift 5.9 |
| UI | UIKit, Programmatic UI, UICollectionView |
| Architecture | VIPER, Dependency Injection |
| Networking | URLSession, REST APIs, Async/Await |
| Concurrency | Swift Concurrency (async/await) |
| Testing | XCTest (Unit Tests + UI Tests) |
| Dependency Manager | CocoaPods |
| Tools | Xcode, Git, GitHub |

---

## 📂 Project Structure

```
Movie Store/
├── Modules/
│   ├── Home/
│   │   ├── View
│   │   ├── Interactor
│   │   ├── Presenter
│   │   ├── Entity
│   │   └── Router
│   ├── Detail/
│   ├── Search/
│   └── Actor/
├── Network/
│   ├── APIService
│   └── Endpoints
├── Common/
│   ├── Extensions
│   └── Reusable Components
└── Resources/
```

---

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 16+
- CocoaPods installed

### Installation

```bash
# Clone the repository
git clone https://github.com/adriancysvillegast/Movie-Store.git

# Navigate into the project
cd Movie-Store

# Install dependencies
pod install

# Open the workspace (NOT the .xcodeproj)
open "Movie Store.xcworkspace"
```

Then build and run on a simulator or physical device.

---

## 🧪 Testing

The project includes **Unit Tests** and **UI Tests** located in:

```
Movie StoreTests/     → Unit tests for Interactors and Presenters
Movie StoreUITests/   → UI flow tests
```

Run tests with `Cmd + U` in Xcode or via the Test Navigator.

---

## 📸 Demo

<!-- Replace with your own screenshots or update the GIF link if needed -->
<p align="center">
  <img src="https://private-user-images.githubusercontent.com/81894293/343218344-ed671940-311f-4198-b2ee-dbc209e5e021.gif" width="280" alt="Movie Store Demo" />
</p>

---

## 🔑 API

This app uses the [TMDB API](https://www.themoviedb.org/documentation/api) to fetch movie, TV show, and actor data.

> To run the project, add your own TMDB API key in the `APIService` configuration file.

---

## 👨‍💻 Author

**Adriancys Jesus Villegas Toro**  
iOS Developer | Swift · UIKit · SwiftUI · VIPER · MVVM

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/adriancys-jesus-villegas-toro-283641160/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/adriancysvillegast)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
