import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthSignUpLoadingState extends AuthState {}

final class AuthSignUpSuccessState extends AuthState {
  final UserCredential userCredential;

  AuthSignUpSuccessState({required this.userCredential});
}

final class AuthSignUpErrorState extends AuthState {
  final String message;
  AuthSignUpErrorState({required this.message});
}

final class AuthSignInLoadingState extends AuthState {}

final class AuthSignInSuccessState extends AuthState {
  final UserCredential userCredential;

  AuthSignInSuccessState({required this.userCredential});
}

final class AuthSignInErrorState extends AuthState {
  final String message;
  AuthSignInErrorState({required this.message});
}

final class AuthSignOutLoadingState extends AuthState {}

final class AuthSignOutSuccessState extends AuthState {}

final class AuthSignOutErrorState extends AuthState {
  final String message;
  AuthSignOutErrorState({required this.message});
}

final class AuthPasswordResetEmailSuccessState extends AuthState {}

final class AuthPasswordResetEmailErrorState extends AuthState {
  final String message;
  AuthPasswordResetEmailErrorState({required this.message});
}

final class AuthEmailVerificationSuccessState extends AuthState {}

final class AuthEmailVerificationErrorState extends AuthState {
  final String message;
  AuthEmailVerificationErrorState({required this.message});
}

final class AuthGoogleSignInLoadingState extends AuthState {}

final class AuthGoogleSignInSuccessState extends AuthState {
  final UserCredential userCredential;
  AuthGoogleSignInSuccessState({required this.userCredential});
}

final class AuthGoogleSignInErrorState extends AuthState {
  final String message;
  AuthGoogleSignInErrorState({required this.message});
}
