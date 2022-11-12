import 'dart:convert';

import 'package:dreavy/models/picture_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PicturesGrid extends StatefulWidget {
  const PicturesGrid({
    Key? key,
    required this.photos,
    this.onDelete,
  }) : super(key: key);

  final List<PictureModel>? photos;
  final void Function(String)? onDelete;

  @override
  State<PicturesGrid> createState() => _PicturesGridState();
}

class _PicturesGridState extends State<PicturesGrid> {
  String _idToDelete = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: GridView.count(
        crossAxisCount: kIsWeb ? 5 : 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio:
            (MediaQuery.of(context).size.width * (kIsWeb ? 0.25 : 0.3)) /
                (MediaQuery.of(context).size.height * (kIsWeb ? 1.0 : 0.285)),
        children: <Widget>[
          if (widget.photos != null)
            for (PictureModel photo in widget.photos!)
              Stack(
                children: <Widget>[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    onEnd: () {
                      widget.onDelete!(photo.id);
                      setState(() => _idToDelete = '');
                    },
                    height: _idToDelete == photo.id ? 0.0 : 2048.0,
                    child: Center(
                      child: Image.memory(
                        base64Decode(photo.base64),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (widget.onDelete != null && _idToDelete != photo.id)
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.white54,
                          child: InkWell(
                            splashColor: Colors.white70,
                            onTap: () => setState(() {
                              if (_idToDelete.isEmpty) {
                                _idToDelete = photo.id;
                              }
                            }),
                            child: const SizedBox(
                              width: 32.0,
                              height: 32.0,
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          if (widget.photos == null) Container(),
        ],
      ),
    );
  }
}
