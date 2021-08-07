import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour_guide/models/app_user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<AppUser?> get appUser {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => user != null ? AppUser.fromFirebaseUser(user) : null);
  }

  Future<AppUser> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return Future.error("Google Signin Failed");
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    UserCredential _userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    User? _user = _userCredential.user;
    if (_user == null) {
      return Future.error('Failed to get user from firebase');
    }
    return AppUser.fromFirebaseUser(_user);
  }

  Future<void> signOut() async {
    //TODO: Catch error
    return await _firebaseAuth.signOut();
  }
}
