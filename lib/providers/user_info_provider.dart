import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreavy/firebase_options.dart';
import 'package:dreavy/models/user_model.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Key;

class UserInfoProvider extends ChangeNotifier {
  UserInfoProvider() : super() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((_) => _db = FirebaseFirestore.instance);
  }

  late final FirebaseFirestore? _db;
  late UserModel? _user;
  bool _isLogged = false;

  String getBase64Encrypted(String data) {
    final Key key = Key.fromUtf8('?E(H+MbQeThWmZq4t7w!z%C*F)J@NcRf');
    final Encrypted encrypted =
        Encrypter(AES(key)).encrypt(data, iv: IV.fromLength(16));

    return encrypted.base64;
  }

  String getBase64Decrypted(String encoded) {
    final Key key = Key.fromUtf8('?E(H+MbQeThWmZq4t7w!z%C*F)J@NcRf');
    final String decrypted = Encrypter(AES(key))
        .decrypt(Encrypted.fromUtf8(encoded), iv: IV.fromLength(16));

    return decrypted;
  }

  void logout() {
    _user = null;
    _isLogged = false;
    notifyListeners();
  }

  Future<void> getUser(String email, String pwd) async {
    try {
      final QuerySnapshot<Map<String, dynamic>>? query = await _db
          ?.collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: getBase64Encrypted(pwd))
          .get();
      final Map<String, dynamic> data = query!.docs.first.data();

      _user = UserModel.fromQuery(<String, dynamic>{
        'id': query.docs.first.id,
        ...data,
      });
      _isLogged = true;
      notifyListeners();
    } on Exception catch (_, e) {
      print(e);
    }
  }

  Future<void> addUser(String email, String pwd, String pseudo) async {
    final String encrypted = getBase64Encrypted(pwd);

    try {
      final DocumentReference<Map<String, dynamic>>? doc =
          await _db?.collection('users').add(<String, dynamic>{
        'admin': false,
        'date': DateTime.now(),
        'email': email,
        'password': encrypted,
        'pseudo': pseudo,
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
