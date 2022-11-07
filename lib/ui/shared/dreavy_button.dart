import 'package:flutter/material.dart';

class DreavyButton extends StatelessWidget {
  const DreavyButton({
    Key? key,
    this.width = 176.0,
    this.height = 48.0,
    required this.onPress,
    required this.label,
  }) : super(key: key);

  final void Function()? onPress;
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.white30),
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.black, Colors.black54],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: Size(height, width),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromRGBO(220, 220, 220, 1.0),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
