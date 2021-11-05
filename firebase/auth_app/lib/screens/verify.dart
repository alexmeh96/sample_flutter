import 'dart:async';

import 'package:auth_app/blocs/authentication_bloc.dart';
import 'package:auth_app/blocs/authentication_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key key, this.firebaseUser}) : super(key: key);

  final User firebaseUser;

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('На ваш email ${user.email} было отправлено письмо с подтверждением'),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();

      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationStarted(),
      );

      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
