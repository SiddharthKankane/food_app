# food_app

A new Flutter project.

## Project Structure

```text
lib/
│
├── models/
│   └── item_model.dart             # (Defines Item and CartItem)
│
├── providers/
│   └── cart_provider.dart          # (Handles math, add/remove, and total price)
│
├── services/
│   └── mock_api_service.dart       # (Simulates the 2-second checkout delay)
│
├── screens/
│   ├── auth/
│   │   ├── auth_screen.dart        # (Tabs for Login/Register)
│   │   ├── login_screen.dart       # (Navigates to MainLayout on click)
│   │   └── register_screen.dart    # (GPS location and photo picker)
│   │
│   ├── home/
│   │   ├── home_screen.dart        # (Displays the mock food list)
│   │   └── item_detail_screen.dart # (Big image and Add to Cart button)
│   │
│   ├── cart/
│   │   └── cart_screen.dart        # (Swipe to delete, total price, order button)
│   │
│   ├── tracking/
│   │   └── tracking_screen.dart    # (Simulated moving map pin and status bar)
│   │
│   ├── profile/
│   │   └── profile_screen.dart     # (User info and Sign Out button)
│   │
│   ├── splash/
│   │   └── splash_screen.dart      # (3-second startup screen)
│   │
│   └── main_layout.dart            # (Bottom Navigation Bar connecting Home, Tracking, Profile)
│
├── widgets/
│   └── custom_text_field.dart      # (Your reusable text input UI)
│
└── main.dart                       # (Injects CartProvider and starts the app)
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
