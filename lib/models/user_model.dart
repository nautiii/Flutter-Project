import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
    this.id,
    this.email,
    this.password, {
    this.admin = false,
    this.pseudo = '',
    this.profilePicture = '',
  }) : date = DateTime.now();

  UserModel.fromQuery(Map<String, dynamic> query)
      : admin = query['admin'] ?? false,
        date = DateTime.parse((query['date'] as Timestamp).toDate().toString()),
        pseudo = query['pseudo'] ?? 'default',
        profilePicture = query['profile_picture'] ?? '',
        id = query['id'],
        email = query['email'],
        password = query['password'];

  final bool admin;
  final DateTime? date;
  final String pseudo;
  final String profilePicture;
  final String id;
  final String email;
  final String password;
}
