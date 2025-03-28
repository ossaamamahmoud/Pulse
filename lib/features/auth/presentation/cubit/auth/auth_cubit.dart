import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pulse/core/cache/cache_helper.dart';
import 'package:pulse/generated/l10n.dart';

import '../../../../chat/data/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final _credential = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _credential.currentUser;
  }

  Future<void> signUpWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String name,
  }) async {
    try {
      emit(AuthSignUpLoadingState());
      final cred = await _credential.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await _firestore.collection('Users').doc(cred.user!.uid).set(
            UserModel(
              uid: cred.user!.uid,
              name: name,
              email: emailAddress,
            ).toMap(),
          );
      await CacheHelper.setBoolData(key: "Logged", value: true);
      emit(AuthSignUpSuccessState(userCredential: cred));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          AuthSignUpErrorState(
            message: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthSignUpErrorState(
            message: 'The account already exists for that email.',
          ),
        );
      } else {
        emit(
          AuthSignUpErrorState(
            message: e.message ?? 'Authentication error.',
          ),
        );
      }
    } catch (e) {
      emit(AuthSignUpErrorState(message: e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(AuthSignInLoadingState());
      final cred = await _credential.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await CacheHelper.setBoolData(key: "Logged", value: true);
      emit(AuthSignInSuccessState(userCredential: cred));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(
          AuthSignInErrorState(
            message: S.current.invalidEmail,
          ),
        );
      } else if (e.code == 'user-not-found') {
        emit(AuthSignInErrorState(message: S.current.noUserLoggedIn));
      } else if (e.code == 'wrong-password') {
        emit(
          AuthSignInErrorState(
            message: S.current.wrongPassword,
          ),
        );
      } else {
        emit(
          AuthSignInErrorState(
              message: e.message ?? S.current.authenticationError),
        );
      }
    } catch (e) {
      emit(AuthSignInErrorState(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await CacheHelper.setBoolData(key: "Logged", value: false);
      await GoogleSignIn().signOut();
      await _credential.signOut();
      emit(AuthSignOutSuccessState());
    } catch (e) {
      emit(AuthSignOutErrorState(message: e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail({required String emailAddress}) async {
    try {
      await _credential.sendPasswordResetEmail(
        email: emailAddress,
      );
      emit(AuthPasswordResetEmailSuccessState());
    } catch (e) {
      emit(AuthPasswordResetEmailErrorState(message: e.toString()));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _credential.currentUser!.sendEmailVerification();
      emit(AuthEmailVerificationSuccessState());
    } catch (e) {
      emit(AuthEmailVerificationErrorState(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthGoogleSignInLoadingState());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthGoogleSignInErrorState(
            message: S.current.googleSignInCancelled));
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final newCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await _credential.signInWithCredential(newCredential);
      await CacheHelper.setBoolData(key: "Logged", value: true);
      await _firestore.collection('Users').doc(userCredential.user!.uid).set(
            UserModel(
              uid: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? S.current.AnonymousUser,
              email: userCredential.user!.email ?? S.current.AnonymousUser,
            ).toMap(),
          );
      emit(
        AuthGoogleSignInSuccessState(
          userCredential: userCredential,
        ),
      );
    } catch (e) {
      emit(AuthGoogleSignInErrorState(message: e.toString()));
    }
  }
}
