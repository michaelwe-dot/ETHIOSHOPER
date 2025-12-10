import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'src/theme/app_theme.dart';
import 'src/ui/auth/auth_screen.dart';
import 'src/ui/home/home_screen.dart';
import 'src/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase.
  // Make sure google-services.json is in android/app/
  await Firebase.initializeApp(); 
  
  runApp(const EthioShopApp());
}

class EthioShopApp extends StatelessWidget {
  const EthioShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETHIO🛍: Marketplace',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/auth': (context) => const AuthScreen(),
      },
    );
  }
}