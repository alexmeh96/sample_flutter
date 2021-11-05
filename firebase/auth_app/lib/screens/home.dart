import 'package:auth_app/blocs/authentication_bloc.dart';
import 'package:auth_app/blocs/authentication_event.dart';
import 'package:auth_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key, this.firebaseUser}) : super(key: key);

  final User firebaseUser;

  logout(context) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationLoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    print(firebaseUser);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(firebaseUser.email),
            ),
            FlatButton(
              child: Text('Logout'),
              color: Theme.of(context).accentColor,
              onPressed: () {
                logout(context);

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}


