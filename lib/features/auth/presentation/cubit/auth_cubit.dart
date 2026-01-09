//state management for authentication feature
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seekauth/features/auth/domain/entities/app_user.dart';
import 'package:seekauth/features/auth/presentation/cubit/auth_state.dart';
import 'package:seekauth/features/auth/domain/repos/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit(this.authRepo) : super(AuthInitial());
  AppUser? get currentUser => _currentUser;
  //check if user is authenticated
  void checkAuthentication() async {
    emit(AuthLoading());
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  //login with email and password
  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.loginWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  //register with email and password
  Future<void> register(String name,String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.registerWithEmailAndPassword(name,email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  //
  //logout
  void logout() async {
    emit(AuthLoading());
    try {
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  //send password reset email
  void sendPasswordResetEmail(String email) async {
    emit(AuthLoading());
    try {
      await authRepo.sendPasswordResetEmail(email);
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    } 
  }
  //delete account
  void deleteUser() async {
    emit(AuthLoading());
    try {
      await authRepo.deleteUser();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  }