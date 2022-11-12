import 'dart:convert';

import 'package:dreavy/models/picture_model.dart';
import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/shared/glass_profile_header.dart';
import 'package:dreavy/ui/shared/pictures_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.state}) : super(key: key);

  final GoRouterState state;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(
      builder: (_, UserInfoProvider userInfo, __) {
        final List<PictureModel>? ownedPictures = userInfo.photos
            ?.where(
              (PictureModel pic) => pic.userId == (userInfo.user?.id ?? -1),
            )
            .toList();

        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Scaffold(
              extendBodyBehindAppBar: true,
              appBar: GlassProfileHeader(
                shared: ownedPictures?.length ?? 0,
                liked: ownedPictures?.length ?? 0,
                backArrowFunction: () => GoRouter.of(context).go('/home'),
              ),
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      kIsWeb
                          ? 'lib/assets/background_desktop.jpg'
                          : 'lib/assets/background3.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: PicturesGrid(
                  photos: ownedPictures,
                ),
              ),
            ),
            Hero(
              tag: 'picture',
              child: Container(
                margin: const EdgeInsets.only(top: 200.0),
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(222, 222, 222, 1.0),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? profilePic =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (profilePic == null) {
                      if (kDebugMode) {
                        print('error while picking the image');
                      }
                    } else {
                      await userInfo.updateProfilePic(profilePic);
                    }
                  },
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(56.0),
                      child: userInfo.user!.profilePicture.isNotEmpty
                          ? Image.memory(
                              base64Decode(userInfo.user!.profilePicture),
                              fit: BoxFit.fill,
                            )
                          : const Icon(Icons.person, size: 36.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
