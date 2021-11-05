import 'package:auth_app/app.dart';
import 'package:auth_app/repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final AuthRepository authRepository = AuthRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authRepository)..add(AuthenticationStarted()),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => authRepository,
        child: App(),
      ),
    ),
  );
}
