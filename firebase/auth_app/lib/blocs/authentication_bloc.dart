import 'package:auth_app/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthRepository _authRepository;

  AuthenticationBloc(this._authRepository) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStarted();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedIn();
    } else if (event is AuthenticationLoggedInWithGoogle) {
      yield* _mapAuthenticationLoggedInWithGoogle();
    } else if (event is AuthenticationLoggedUp) {
      yield* _mapAuthenticationLoggedUp();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOut();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOut() async* {
    _authRepository.signOut();
    yield AuthenticationFailure();
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedIn() async* {
    // await _authRepository.signInWithEmailAndPassword(email, password);
    yield AuthenticationSuccess(await _authRepository.getUser());
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInWithGoogle() async* {
    // await _authRepository.signInWithGoogle();
    yield AuthenticationSuccess(await _authRepository.getUser());
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedUp() async* {

    // await _authRepository.signUpWithEmailAndPassword(email, password);
    // final firebaseUser = await _authRepository.getUser();
    // firebaseUser.sendEmailVerification();
    yield AuthenticationVerify(await _authRepository.getUser());
  }

  Stream<AuthenticationState> _mapAuthenticationStarted() async* {
    final firebaseUser = await _authRepository.getUser();
    if (firebaseUser != null) {
      if (firebaseUser.emailVerified)
        yield AuthenticationSuccess(firebaseUser);
      else
        yield AuthenticationVerify(firebaseUser);
    } else {
      yield AuthenticationFailure();
    }
  }

}