import 'dart:convert';

import 'package:dreavy/models/picture_model.dart';
import 'package:dreavy/providers/camera_provider.dart';
import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/shared/glass_floating_button.dart';
import 'package:dreavy/ui/shared/glass_toolbar.dart';
import 'package:dreavy/ui/shared/pictures_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.state}) : super(key: key);

  final GoRouterState state;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CameraProvider>(
      create: (_) => CameraProvider(),
      child: Consumer2<CameraProvider, UserInfoProvider>(
        builder: (_, CameraProvider camera, UserInfoProvider userInfo, __) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: GlassToolBar(
              backArrowFunction: userInfo.logout,
              avatar: userInfo.user?.profilePicture,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PicturesGrid(photos: userInfo.photos),
            ),
            floatingActionButton: camera.isInitialized
                ? GlassFloatingButton(
                    size: 64.0,
                    icon: Icons.camera_alt,
                    onPress: () => camera.openCameraView(context, userInfo),
                  )
                : null,
          );
        },
      ),
    );
  }
}
