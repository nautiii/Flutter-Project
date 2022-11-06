import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';

class CameraProvider extends ChangeNotifier {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isInitialized = false;

  Future setupCamera() async {
    try {
      _cameras = await availableCameras();
      print(_cameras);
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

  Future storePhoto(XFile photo) async {
    Uint8List bytes = await photo.readAsBytes();
    String base64 = base64Encode(bytes);
  }

  CameraProvider() : super() {
    setupCamera();
  }

  bool get isInitialized => _isInitialized;
  CameraController get controller => _controller;
}
