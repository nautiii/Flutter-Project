import 'dart:convert';

import 'package:dreavy/models/picture_model.dart';
import 'package:flutter/material.dart';

class PicturesGrid extends StatelessWidget {
  const PicturesGrid({Key? key, required this.photos}) : super(key: key);

  final List<PictureModel>? photos;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: (MediaQuery.of(context).size.width * 0.3) /
          (MediaQuery.of(context).size.height * 0.285),
      children: <Widget>[
        if (photos != null)
          for (PictureModel photo in photos!)
            Image.memory(
              base64Decode(photo.base64),
              fit: BoxFit.contain,
            ),
        if (photos == null) Container(),
      ],
    );
  }
}
