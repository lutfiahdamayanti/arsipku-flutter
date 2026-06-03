import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    _initialized = true;

    await _googleSignIn.initialize();

    _googleSignIn.attemptLightweightAuthentication();
  }

  Future<User?> signInWithGoogle() async {
    try {
      await init();

      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final String? idToken =
          googleUser.authentication.idToken;

      if (idToken == null) {
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}