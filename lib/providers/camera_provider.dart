import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/shared/glass_floating_button.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  CameraProvider() : super() {
    if (!_isInitialized) {
      setupCamera();
      print('setting up');
    } else {
      print('already done');
    }
  }

  late List<CameraDescription> _cameras;
  late CameraController _controller;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool _isInitialized = false;

  Future<void> setupCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
        _cameras.first,
        ResolutionPreset.high,
      );
      await _controller.initialize();
      _isInitialized = true;
      notifyListeners();
    } on CameraException catch (_, e) {
      print(e);
    }
  }

  Future<void> storePhoto(String id, XFile photo) async {
    final Uint8List bytes = await photo.readAsBytes();
    final String encoded = base64Encode(bytes);

    try {
      await _db.collection('pictures').add(<String, dynamic>{
        'user_id': id,
        'base64': encoded,
      });
      print(base64);
    } on Exception catch (_, e) {
      print(e);
    }
  }

  Future<void> openCameraView(
    BuildContext context,
    UserInfoProvider info,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          body: CameraPreview(controller),
          floatingActionButton: GlassFloatingButton(
            size: 64.0,
            icon: Icons.camera,
            onPress: () => controller.takePicture().then((XFile photo) {
              storePhoto(info.user!.id, photo);
              info.getAllPhotos();
              Navigator.of(context).pop();
            }),
          ),
        ),
      ),
    );
  }

  bool get isInitialized => _isInitialized;
  CameraController get controller => _controller;
}
