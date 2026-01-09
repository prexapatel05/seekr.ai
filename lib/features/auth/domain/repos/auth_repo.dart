//auth repo interface
//to be implemented by auth repo implementation
import 'package:seekauth/features/auth/domain/entities/app_user.dart';

import  'package:seekauth/features/auth/domain/entities/app_user.dart';
abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<AppUser?> registerWithEmailAndPassword(String name,String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  
  Future<void> deleteUser();
}