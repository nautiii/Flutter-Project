import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dreavy/firebase_options.dart';

class UserInfoProvider extends ChangeNotifier {
  String _email = '';

  UserInfoProvider() : super() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((value) {
      print('################################# $value');
    });
  }

  void addUser() {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    print('################################# db $db');

    final user = <String, dynamic>{
      "admin": true,
      "date": DateTime.now(),
      "email": "nautiii.games@gmail.com",
      "password": "tmp",
      "pseudo": "nautiii",
    };

    final users = db.collection("users");
    print('################################# users $users');

    users.add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}
