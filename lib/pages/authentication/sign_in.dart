import 'package:flutter/material.dart';
import 'package:tour_guide/models/app_user.dart';
import 'package:tour_guide/services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                try {
                  AppUser _appUser = await _authService.signInWithGoogle();
                  print('Signed in with Google');
                } catch (e) {
                  print(e);
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
