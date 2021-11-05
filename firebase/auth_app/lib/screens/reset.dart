import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Запрос на обновление пароля'),
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
            child: Text("На ваш email прийдёт письмо с ссылкой для ввода нового пароля"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);
                  Navigator.of(context).pop();
                },
                child: Text('Отправить запрос'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
