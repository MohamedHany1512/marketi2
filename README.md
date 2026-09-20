# 🛒 Marketi App

A complete E-Commerce application built with **Flutter**, adhering to modern development best practices, **Clean Architecture**, and **Cubit / Bloc** state management.

---

## 📸 Screenshots

| Home Screen | Shopping Cart | Product Details | User Profile |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/1.png" width="200"/> | <img src="screenshots/2.png" width="200"/> | <img src="screenshots/3.png" width="200"/> | <img src="screenshots/4.png" width="200"/> |

| Authentication | Favorites | Search | Payment |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/10.png" width="200"/> | <img src="screenshots/11.png" width="200"/> | <img src="screenshots/12.png" width="200"/> | <img src="screenshots/13.png" width="200"/> |

---

## ✨ Features

* 🔐 **Authentication:** Sign up and Login functionality.
* 🛍️ **Home & Catalog:**
  * Browse categories and brands.
  * Product listings and detailed views.
* 🔍 **Search & Filter:** Instant search with debouncer implementation to optimize network requests.
* ❤️ **Wishlist:** Add and remove products from favorites.
* 🛒 **Shopping Cart:** Manage cart items and quantities.
* 💳 **Payment Integration:** Integrated **Paymob** payment gateway via WebView.
* 👤 **User Profile:** Manage user profile information.
* 🚀 **Onboarding:** Interactive introduction screens for new users.

---

## 🏗️ Project Architecture

Built using **Feature-First Clean Architecture** to ensure separation of concerns, scalability, and testability:

```text
lib/
├── core/                         # Shared utilities, services, and configurations
│   ├── common/                   # Custom Widgets & Helpers
│   ├── errors/                   # Error handling & Exception models
│   ├── helper/                   # CacheHelper (Shared Preferences)
│   ├── network/                  # Dio API Consumer, Interceptors & Endpoints
│   ├── routing/                  # App Router & Route definitions
│   ├── services/                 # Dependency Injection (GetIt Service Locator)
│   └── themes/                   # App Theme & Color palettes
│
└── features/                     # Feature modules
    ├── auth/                     # Authentication (Login & Register)
    ├── cart/                     # Cart Management
    ├── favorite/                 # Favorites / Wishlist
    ├── home/                     # Products, Categories, Brands & Details
    ├── onboarding/               # Onboarding flow
    ├── payment/                  # Paymob Integration & WebView
    ├── profile/                  # User Profile
    └── search/                   # Search functionality


🛠️ Tech Stack & Dependencies
Framework: Flutter ( свойства & Dart)

State Management: Flutter Bloc / Cubit

Networking: Dio

Dependency Injection: GetIt

Local Storage: Shared Preferences

Routing: Native Dynamic Routing (AppRouter)

Payment Gateway: Paymob SDK / Webview

🚀 Getting Started
Clone the repository:

Bash
git clone [https://github.com/your-username/marketi_app.git](https://github.com/your-username/marketi_app.git)
cd marketi_app
Install dependencies:

Bash
flutter pub get
Run the app:

Bash
flutter run
