// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    // Comment this line for production
    // bool isAndroid = Platform.isAndroid;
    // String host = isAndroid ? '10.0.2.2:5002' : 'localhost:5002';
    // _db.settings = Settings(host: host, sslEnabled: false);
  }

  Future saveAgent(AgentModel user, String uid) async {
    try {
      user.uid = uid;
      // Main Doc
      DocumentReference mainDocRef = _db.collection('users').doc(uid);
      // Save data
      await mainDocRef.set(user.toFirestore());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }
}
