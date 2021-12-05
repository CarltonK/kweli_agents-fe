import 'package:cloud_firestore/cloud_firestore.dart';

class AgentModel {
  String? uid;
  String? email;
  String? password;
  DateTime? joinedOn;

  AgentModel({this.email, this.password, this.uid, this.joinedOn});

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'email': email,
        'joinedOn': joinedOn,
      };
}
