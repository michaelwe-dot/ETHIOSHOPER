import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethiomark8/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final user = authService.getCurrentUser();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(height: 20),
            Text(
              user?.displayName ?? 'No Name',
              style: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              user?.email ?? 'No Email',
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await authService.signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
