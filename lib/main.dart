import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/pages/auth_wrapper.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/loading.dart';
import 'package:tour_guide/services/auth.dart';

import 'models/app_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        var child;
        if (snapshot.hasError) {
          return MaterialApp(
              home: ErrorPage(message: snapshot.error.toString()));
        }
        // Once complete, show your application
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: LoadingPage());
        } else {
          return StreamProvider<AppUser?>.value(
            value: AuthService().appUser,
            initialData: null,
            child: MaterialApp(home: AuthWrapper()),
          );
        }
      },
    );
  }
}
