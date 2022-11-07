import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(8.0),
    this.blurSigma = 12.0,
    this.radius = 16.0,
    required this.height,
    required this.width,
    required this.child,
  }) : super(key: key);

  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final double blurSigma;
  final double radius;
  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          height: height,
          width: width,
          padding: padding,
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
              colors: <Color>[Colors.white54, Colors.white30, Colors.white10],
            ),
            border: Border.all(width: 2.0, color: Colors.white30),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
