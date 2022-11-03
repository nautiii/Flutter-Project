import 'package:flutter/material.dart';

import 'dart:ui';

class GlassContainer extends StatelessWidget {
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final double blurSigma;
  final double height;
  final double width;
  final Widget child;

  const GlassContainer(
      {Key? key,
      this.alignment = Alignment.center,
      this.padding = const EdgeInsets.all(8.0),
      this.blurSigma = 12.0,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24.0,
                spreadRadius: -8.0,
              )
            ],
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [Colors.white54, Colors.white30, Colors.white10]),
            border: Border.all(width: 2.0, color: Colors.white30),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
