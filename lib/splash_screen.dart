import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:ethiomark8/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoNetworkDialog();
    } else {
      Timer(const Duration(seconds: 5), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
        );
      });
    }
  }

  void _showNoNetworkDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            "No Internet Connection",
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You are not connected to the internet. Please check your connection and try again.",
                style: GoogleFonts.openSans(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "For support, contact us at:",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              Text(
                "☎️ 0941090959",
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "📧 Ethiopianmark8@gmail.com",
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkConnectivity();
              },
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: 150,
                color: Colors.green.shade400,
              ),
              const SizedBox(height: 20),
              Text(
                "ETHIOMARK8",
                style: GoogleFonts.oswald(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.green.withAlpha(128),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              Text(
                "ONLINE SHOPPING CENTER",
                style: GoogleFonts.roboto(
                    fontSize: 16.0, color: Colors.white70, letterSpacing: 1.5),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: 220,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[800],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Contact: 0941090959',
                style: GoogleFonts.openSans(
                  fontSize: 12.0,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
