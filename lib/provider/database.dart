import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    // Comment this line for production
    _db.useFirestoreEmulator('localhost', 8080);
  }

  Future saveAgent(AgentModel user, String uid) async {
    try {
      user.uid = uid;
      // Main Doc
      DocumentReference mainDocRef = _db.collection('agents').doc(uid);
      // Save data
      await mainDocRef.set(user.toFirestore());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }
}
