import 'package:auth_app/blocs/authentication_bloc.dart';
import 'package:auth_app/blocs/authentication_event.dart';
import 'package:auth_app/repository/auth_repository.dart';
import 'package:auth_app/screens/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  AuthRepository _authRepository;

  // AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    _authRepository = RepositoryProvider.of<AuthRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () => _signIn(context, _email, _password),
                child: Text('Sign In'),
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () => _signUp(context, _email, _password),
                child: Text('Sign up'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetScreen()));
                },
                child: Text('Forgot password?'),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                // authBloc.loginGoogle();
                _signInWithGoogle(context);

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          )
        ],
      ),
    );
  }

  _signIn(BuildContext context, String _email, String _password) async {
    try {
      await _authRepository.signInWithEmailAndPassword(_email, _password);

      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedIn(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    }

  }

  _signInWithGoogle(BuildContext context) async {
    try {
      await _authRepository.signInWithGoogle();
      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedInWithGoogle(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    } catch (e) {
      print(e);
    }
  }

  _signUp(BuildContext context, String _email, String _password) async {
    try {
      await _authRepository.signUpWithEmailAndPassword(_email, _password);
      final firebaseUser = await _authRepository.getUser();
      firebaseUser.sendEmailVerification();

      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedUp(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
    }
  }

// _signIn(String _email, String _password) async {
//   try {
//     await auth.signInWithEmailAndPassword(email: _email, password: _password);
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()));
//   } on FirebaseAuthException catch (e) {
//     print(e.message);
//     Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
//   }
// }
//
// _signUp(String _email, String _password) async {
//   try {
//     await auth.createUserWithEmailAndPassword(
//         email: _email, password: _password);
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()));
//   } on FirebaseAuthException catch (e) {
//     print(e.message);
//     Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
//   }
// }
}
