import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlassProfileHeader extends StatelessWidget implements PreferredSize {
  const GlassProfileHeader({
    Key? key,
    required this.backArrowFunction,
    required this.shared,
    required this.liked,
  }) : super(key: key);

  final void Function() backArrowFunction;
  final int shared;
  final int liked;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          height: 240.0 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            right: 8.0,
            top: MediaQuery.of(context).padding.top,
          ),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24.0,
                spreadRadius: -8.0,
              )
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.white70, Colors.white38],
            ),
            border: Border.all(width: 2.0, color: Colors.white30),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => GoRouter.of(context).pop(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Shared photos',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text('$shared'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size.fromHeight(252.0);
}
