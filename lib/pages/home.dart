import 'package:flutter/material.dart';
import 'package:tour_guide/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () async {
              await _authService.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Sign Out'),
          )
        ],
      ),
      body: Center(
        child: Text("Content"),
      ),
    );
  }
}
