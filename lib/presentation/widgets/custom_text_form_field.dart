import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.orange),
    );
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        hintText: 'Search Food or Restaurants ...',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[400],
        ),
        prefixIcon: const Icon(Icons.search, size: 30),
        suffixIcon: const Icon(Icons.close, size: 30),
      ),
    );
  }
}
