import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Use a factory constructor or a static instance for GoogleSignIn to ensure consistency
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      developer.log('Starting Google Sign-In process', name: 'ethio.auth');
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in flow, googleUser will be null
      if (googleUser == null) {
        developer.log('Google Sign-In canceled by user', name: 'ethio.auth');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      developer.log('Google Sign-In successful', name: 'ethio.auth');
      return userCredential;
      
    } catch (e, stackTrace) {
      developer.log(
        'Error during Google Sign-In',
        name: 'ethio.auth',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      developer.log('User signed out', name: 'ethio.auth');
    } catch (e) {
      developer.log('Error during sign out', name: 'ethio.auth', error: e);
    }
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
