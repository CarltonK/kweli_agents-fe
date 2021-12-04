// ignore_for_file: constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  User? _currentUser;
  User get user => _currentUser!;

  AuthProvider.instance() : auth = FirebaseAuth.instance {
    // auth.useAuthEmulator('localhost', 9099);
    auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _currentUser = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await auth.signInWithCredential(credential);
  }
}
