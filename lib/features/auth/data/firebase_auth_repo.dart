import 'package:firebase_auth/firebase_auth.dart';
import 'package:seekauth/features/auth/domain/entities/app_user.dart';
import 'package:seekauth/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepository implements AuthRepo {
  // Firebase Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // LOGIN
  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // REGISTER
  @override
  Future<AppUser?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
      );
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // LOGOUT
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return AppUser(
        uid: user.uid,
        email: user.email!,
      );
    }
    return null;
  }

  // PASSWORD RESET
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent';
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  // DELETE USER
  @override
  Future<void> deleteUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      await user.delete();
      await logout();
    } catch (e) {
      throw Exception('Delete user failed: $e');
    }
  }
}
