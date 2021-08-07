import 'package:flutter/material.dart';
import 'package:tour_guide/pages/authentication/sign_in.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({Key? key}) : super(key: key);

  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SignIn(),
      ),
    );
  }
}
