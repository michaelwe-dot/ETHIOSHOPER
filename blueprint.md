# Project Overview

A Flutter application named "EthioMark8" with Firebase integration. The app is an e-commerce platform for Ethiopian products, featuring marketplace listings, job listings, and in-app messaging.

# Style, Design, and Features

*   **Firebase Integration:**
    *   Firebase Authentication (Google Sign-In)
    *   Cloud Firestore for data storage
    *   SHA-1 fingerprint configured for debug builds in Firebase.
*   **Branding:**
    *   App Name: EthioMark8
    *   Package Name: `com.ethio.shop`
    *   App Icon: `assets/images/logo.png` (Configured via `flutter_launcher_icons`)
*   **UI/UX:**
    *   Premium animated splash screen.
    *   Modern card layouts with staggered animations.
    *   Marketplace listing with swipeable photo galleries.
    *   In-app chat system.
    *   User profile dashboard.

# Current Task: Generate New APK

*   **Objective:** Build a fresh, release-ready APK after all fixes and configurations.
*   **Steps:**
    1.  Update `blueprint.md` to reflect the latest status.
    2.  Clean the project build artifacts (`flutter clean`).
    3.  Ensure all dependencies are correctly fetched (`flutter pub get`).
    4.  Build the APK (`flutter build apk`).
