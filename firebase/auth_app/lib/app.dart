import 'package:auth_app/screens/home.dart';
import 'package:auth_app/screens/login.dart';
import 'package:auth_app/screens/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_state.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth app',
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.blue
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen();
          }
          if (state is AuthenticationVerify) {
            return VerifyScreen(firebaseUser: state.firebaseUser);
          }
          if (state is AuthenticationSuccess) {
            return HomeScreen(firebaseUser: state.firebaseUser);
          }
          return Scaffold(
            body: Container(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      ),
    );
  }
}
