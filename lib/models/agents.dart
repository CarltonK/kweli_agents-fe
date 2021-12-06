class AgentModel {
  String? fullName;
  String? phone;
  String? uid;
  String? email;
  String? password;
  DateTime? joinedOn;

  AgentModel({
    this.email,
    this.password,
    this.uid,
    this.joinedOn,
    this.fullName,
    this.phone,
  });

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'email': email,
        'joinedOn': joinedOn,
        'fullName': fullName,
        'phone': phone,
      };
}
