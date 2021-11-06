import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository? _authRepository;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(Paths.users);

  LoginCubit({@required AuthRepository? authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void logInWithGoogle() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _authRepository!.signInWithGoogle();

      final doc = await usersRef.doc(user?.uid).get();

      if (user != null) {
        if (!doc.exists) {
          await usersRef.doc(user.uid).set(user.toMap());
        }
      }
      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          failure: Failure(message: error.message),
        ),
      );
    }
  }

  void appleLogin() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _authRepository!.signInWithApple();
      if (user != null) {
        final doc = await usersRef.doc(user.uid).get();
        if (!doc.exists) {
          usersRef.doc(user.uid).set(user.toMap());
        }
      }

      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          failure: Failure(message: error.message),
        ),
      );
    }
  }
}
