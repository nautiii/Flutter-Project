import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dreavy/providers/camera_provider.dart';
import 'package:dreavy/ui/shared/glass_toolbar.dart';

import 'dart:convert';
import 'dart:typed_data';

class HomePage extends StatefulWidget {
  final GoRouterState state;

  const HomePage({Key? key, required this.state}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraProvider(),
      child: Consumer<CameraProvider>(
        builder: (_, camera, __) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const GlassToolBar(),
          body: GridView.count(
            crossAxisCount: 2,
            children: [
              for (int i = 0; i < 10; i++)
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.redAccent,
                  margin: const EdgeInsets.all(8.0),
                )
            ],
          ),
          floatingActionButton: camera.isInitialized
              ? FloatingActionButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        // camera.openCameraView(context)
                        builder: (BuildContext context) => Scaffold(
                              body: CameraPreview(camera.controller),
                              floatingActionButton: FloatingActionButton(
                                elevation: 0.0,
                                onPressed: () => camera.controller
                                    .takePicture()
                                    .then((XFile photo) {
                                  print(photo.path);
                                  photo.readAsBytes().then((Uint8List bytes) {
                                    String img64 = base64Encode(bytes);
                                    print(img64);
                                    Navigator.of(context).pop();
                                  });
                                }),
                                child: const Icon(Icons.camera),
                              ),
                            )),
                  ),
                  backgroundColor: Colors.red.shade700,
                  child: const Icon(Icons.camera_alt),
                )
              : null,
        ),
      ),
    );
  }
}
