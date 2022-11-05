import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final bool? admin;
  final DateTime? date;
  final String? pseudo;
  final String id;
  final String email;
  final String password;

  UserModel(this.id, this.email, this.password,
      {this.admin = false, this.pseudo = ''})
      : date = DateTime.now();

  UserModel.fromQuery(Map<String, dynamic> query)
      : admin = query['admin'],
        date = DateTime.parse((query['date'] as Timestamp).toDate().toString()),
        pseudo = query['pseudo'],
        id = query['id'],
        email = query['email'],
        password = query['password'];
}
