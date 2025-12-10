import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Text
            const Text(
              "ETHIO🛍",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGreen,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            // Loading Indicator
            const CircularProgressIndicator(
              color: AppTheme.secondaryYellow,
            ),
          ],
        ),
      ),
    );
  }
}