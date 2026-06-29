import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// User yang sedang login
  static User? get currentUser => _auth.currentUser;

  /// Status login
  static bool get isLoggedIn => currentUser != null;

  /// Register
  static Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    // Simpan nama pengguna ke Firebase Authentication
    await credential.user?.updateDisplayName(name.trim());

    // Refresh data user agar displayName langsung tersedia
    await credential.user?.reload();

    return credential;
  }

  /// Login
  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  /// Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }
}