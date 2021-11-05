abstract class AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLoggedInWithGoogle extends AuthenticationEvent {}

class AuthenticationLoggedUp extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}
