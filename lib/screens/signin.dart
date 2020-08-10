import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:assignment_4_cst407/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signin extends StatelessWidget {
  Signin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'my anime list',
      theme: LoginTheme(
        primaryColor: Colors.black,
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 53,
        ),
        cardTheme: CardTheme(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
       onLogin: (LoginData credentials) => authProvider.readOwner(ProviderStateOwner()).state.signIn(credentials.name, credentials.password), 
       //TODO: recover password
       onRecoverPassword: null, 
       onSignup: (LoginData credentials) => authProvider.readOwner(ProviderStateOwner()).state.registerWithEmailAndPassword(credentials.name, credentials.password),
       onSubmitAnimationCompleted: () => Navigator.pushNamed(context, '/home'),
    );
  }
}
