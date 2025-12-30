import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethiomark8/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final AuthService authService = AuthService();

  Future<void> _signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await authService.signInWithGoogle();
      // Navigation is handled by AuthWrapper in main.dart
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ETHIO🛍',
                    style: GoogleFonts.oswald(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton.icon(
                    onPressed: _signIn,
                    icon: Image.asset('assets/images/google_logo.png', height: 24.0),
                    label: Text(
                      'Sign in with Google',
                      style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
