import 'package:flutter/material.dart' hide Key;
import 'package:encrypt/encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:dreavy/firebase_options.dart';
import 'package:dreavy/models/user_model.dart';

class UserInfoProvider extends ChangeNotifier {
  late final FirebaseFirestore? _db;
  late UserModel? _user;
  bool _isLogged = false;

  UserInfoProvider() : super() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((_) => _db = FirebaseFirestore.instance);
  }

  String getBase64Encrypted(String data) {
    final key = Key.fromUtf8('?E(H+MbQeThWmZq4t7w!z%C*F)J@NcRf');
    final encrypted = Encrypter(AES(key)).encrypt(data, iv: IV.fromLength(16));

    return encrypted.base64;
  }

  String getBase64Decrypted(String encoded) {
    final key = Key.fromUtf8('?E(H+MbQeThWmZq4t7w!z%C*F)J@NcRf');
    final decrypted = Encrypter(AES(key))
        .decrypt(Encrypted.fromUtf8(encoded), iv: IV.fromLength(16));

    return decrypted;
  }

  void logout() {
    _user = null;
    _isLogged = false;
  }

  Future getUser(String email, String pwd) async {
    try {
      final QuerySnapshot<Map<String, dynamic>>? query = await _db
          ?.collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: getBase64Encrypted(pwd))
          .get();
      final data = query!.docs.first.data();

      _user = UserModel.fromQuery({
        'id': query.docs.first.id,
        ...data,
      });
      _isLogged = true;
      notifyListeners();
    } on Exception catch (_, e) {
      print(e);
    }
  }

  Future addUser(String email, String pwd, String pseudo) async {
    final encrypted = getBase64Encrypted(pwd);

    try {
      DocumentReference? doc = await _db?.collection("users").add({
        "admin": false,
        "date": DateTime.now(),
        "email": email,
        "password": encrypted,
        "pseudo": pseudo,
      });

      print('DocumentSnapshot added with ID: ${doc!.id}');
      _user = UserModel(doc.id, email, encrypted);
      _isLogged = true;
      notifyListeners();
    } on Exception catch (_, e) {
      print(e);
    }
  }

  UserModel? get user => _user;
  bool get isLogged => _isLogged;
}
