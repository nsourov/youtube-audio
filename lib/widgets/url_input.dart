import 'package:flutter/material.dart';

class UrlInput extends StatelessWidget {
  const UrlInput({
    super.key,
    required this.onChange,
  });

  final Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: 'URL...',
      ),
    );
  }
}
