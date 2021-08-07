import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/models/app_user.dart';
import 'package:tour_guide/pages/authentication/authenticate.dart';
import 'package:tour_guide/pages/home.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AppUser?>(context);
    return _user == null ? AuthenticatePage() : HomePage();
  }
}
