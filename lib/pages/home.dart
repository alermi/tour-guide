import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tour_guide/pages/map.dart';
import 'package:tour_guide/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    Permission.location.request();
  }

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
        child: MapPage(),
      ),
    );
  }
}
