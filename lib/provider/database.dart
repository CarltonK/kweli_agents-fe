import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    // Comment this line for production
    // _db.useFirestoreEmulator('localhost', 8080);
  }

  Future saveAgent(AgentModel user, String uid) async {
    try {
      user.uid = uid;
      DocumentReference mainDocRef = _db.collection('agents').doc(uid);
      await mainDocRef.set(user.toFirestore());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future saveWholeseller(WholesellerModel wholeseller) async {
    try {
      CollectionReference colRef = _db.collection('wholesellers');
      await colRef.add(wholeseller.toMap());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future saveKiosk(KioskModel kiosk) async {
    try {
      CollectionReference colRef = _db.collection('kiosks');
      await colRef.add(kiosk.toMap());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }
}
