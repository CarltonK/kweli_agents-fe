// ignore_for_file: constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../provider/provider.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider extends DatabaseProvider with ChangeNotifier {
  final FirebaseAuth auth;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  User? _currentUser;
  User get user => _currentUser!;

  AuthProvider.instance() : auth = FirebaseAuth.instance {
    auth.useAuthEmulator('localhost', 9099);
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

  Future createUser(AgentModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      _currentUser = result.user;
      String uid = _currentUser!.uid;

      // Send an email verification
      await _currentUser!.sendEmailVerification();
      // Save the user to the database
      await saveAgent(user, uid);

      return Future.value(_currentUser);
    } on FirebaseAuthException catch (error) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return error.message;
    }
  }

  Future signInEmailPass(AgentModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      _currentUser = result.user;

      return Future.value(_currentUser);
    } on FirebaseAuthException catch (error) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return error.message;
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }
}
