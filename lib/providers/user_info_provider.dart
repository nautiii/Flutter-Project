import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreavy/firebase_options.dart';
import 'package:dreavy/models/picture_model.dart';
import 'package:dreavy/models/user_model.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' hide Key;

class UserInfoProvider extends ChangeNotifier {
  UserInfoProvider() : super() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((_) => _db = FirebaseFirestore.instance);
  }

  late final FirebaseFirestore? _db;
  late UserModel? _user;
  List<PictureModel>? _photos;
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
      await getAllPhotos();
    } on Exception catch (_, e) {
      if (kDebugMode) {
        print(e);
      }
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

      _user = UserModel(doc!.id, email, encrypted);
      _isLogged = true;
      await getAllPhotos();
    } on Exception catch (_, e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAllPhotos() async {
    final QuerySnapshot<Map<String, dynamic>>? pics =
        await _db?.collection('pictures').get();

    _photos = pics?.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> pic) =>
              PictureModel.fromQuery(<String, dynamic>{
            'id': pic.id,
            ...pic.data(),
          }),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deletePhoto(String id) async {
    await _db?.collection('pictures').doc(id).delete().then((_) {
      _photos?.removeWhere((PictureModel photo) => photo.id == id);
      notifyListeners();
    }).catchError((Object error) {
      if (kDebugMode) {
        print('Failed to delete picture: $error');
      }
    });
  }

  Future<void> updateProfilePic(XFile picture) async {
    final Uint8List bytes = await picture.readAsBytes();
    final String encoded = base64Encode(bytes);

    await _db
        ?.collection('users')
        .doc(_user!.id)
        .update(<String, dynamic>{'profile_picture': encoded}).then((_) {
      notifyListeners();
    }).catchError((Object error){
      if (kDebugMode) {
        print('Failed: $error');
      }
    });
  }

  UserModel? get user => _user;
  bool get isLogged => _isLogged;
  List<PictureModel>? get photos => _photos;
}
