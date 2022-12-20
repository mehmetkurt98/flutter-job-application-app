import 'package:flutter/material.dart';

class MainTextFormField extends StatefulWidget {
  const MainTextFormField(
      {Key? key,
      required this.labelText,
      required this.onChanged,
      required this.controller})
      : super(key: key);
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 2),
        ),
      ),
    );
  }
}
