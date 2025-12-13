name: 🚀 Flutter Android CI/CD

# 1. TRIGER: Run on push to main or manually
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch: # Allows manual trigger from GitHub Actions tab

# Global Environment Variables
env:
  FLUTTER_VERSION: '3.22.x' # Set to your project's version
  JAVA_VERSION: '21.0.x'    # Recommended Java version for latest Flutter SDK

jobs:
  build_android:
    name: Build & Deploy Android AAB
    runs-on: ubuntu-latest

    steps:
      # --- SETUP ---

      - name: 1. ⬇️ Checkout Repository
        uses: actions/checkout@v4

      - name: 2. ☕ Set up JDK
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: ${{ env.JAVA_VERSION }}

      - name: 3. 💙 Set up Flutter SDK
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true
      
      # 4. 📦 Cache and Install Dependencies
      - name: 4. Cache Pub Packages
        uses: actions/cache@v4
        with:
          path: |
            ~/.pub-cache
          key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
          restore-keys: |
            ${{ runner.os }}-pub-
      
      - name: 5. Get Flutter Dependencies
        run: flutter pub get

      # --- CODE QUALITY & TESTS (Recommended) ---

      - name: 6. 🧹 Run Flutter Analyzer
        run: flutter analyze

      - name: 7. 🧪 Run Flutter Tests
        run: flutter test --no-pub --coverage

      # --- SECURE SIGNING FIX ---
      
      # Inject the Base64-encoded keystore file into the runner environment
      - name: 8. Inject Release Keystore (JKS)
        if: ${{ secrets.KEY_STORE_FILE_BASE64 != '' }}
        run: |
          # Decode Base64 Secret and save it as release-key.jks
          echo "${{ secrets.KEY_STORE_FILE_BASE64 }}" | base64 --decode > android/app/release-key.jks
          
          # Create key.properties file with secret values for Gradle
          echo "storeFile=release-key.jks" > android/key.properties
          echo "keyAlias=${{ secrets.KEY_ALIAS }}" >> android/key.properties
          echo "keyPassword=${{ secrets.KEY_ALIAS_PASSWORD }}" >> android/key.properties
          echo "storePassword=${{ secrets.KEY_STORE_PASSWORD }}" >> android/key.properties
        shell: bash

      # --- BUILD ---

      - name: 9. 🧹 Clean Build Environment
        run: flutter clean

      - name: 10. 🏗️ Build Android Release AAB (App Bundle)
        # The build will automatically use the key.properties for signing
        run: flutter build appbundle --release --no-tree-shake-icons

      # --- UPLOAD ARTIFACTS ---

      - name: 11. 💾 Upload Release AAB Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ethio_shop-release-aab
          path: build/app/outputs/bundle/release/app-release.aab # Standard AAB output path
          retention-days: 7
