import 'package:camera/camera.dart';
import 'package:dreavy/providers/camera_provider.dart';
import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/shared/glass_floating_button.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({
    Key? key,
    required this.info,
    required this.cam,
  }) : super(key: key);

  final UserInfoProvider info;
  final CameraProvider cam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraPreview(cam.controller),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GlassFloatingButton(
            size: 64.0,
            icon: Icons.arrow_back,
            onPress: () => Navigator.of(context).pop(),
          ),
          GlassFloatingButton(
            size: 64.0,
            icon: Icons.camera,
            onPress: () => cam.controller.takePicture().then((XFile photo) {
              cam.storePhoto(info.user!.id, photo);
              Navigator.of(context).pop();
              info.getAllPhotos();
            }),
          ),
        ],
      ),
    );
  }
}
