import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {
  AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationVerify extends AuthenticationState {
  final User firebaseUser;
  AuthenticationVerify(this.firebaseUser);
}

class AuthenticationSuccess extends AuthenticationState {
  final User firebaseUser;
  AuthenticationSuccess(this.firebaseUser);
}

class AuthenticationFailure extends AuthenticationState {}