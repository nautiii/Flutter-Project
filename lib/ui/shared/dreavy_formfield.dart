import 'package:flutter/material.dart';

class DreavyFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool hide;

  const DreavyFormField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.validator,
      required this.controller,
      this.hide = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: hide,
        enableSuggestions: true,
        cursorColor: Colors.black87,
        style: const TextStyle(color: Color.fromRGBO(222, 222, 222, 1.0)),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black87,
            size: 28.0,
          ),
          suffixIcon: hide
              ? const Icon(Icons.remove_red_eye,
                  color: Colors.black87, size: 28.0)
              : null,
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
