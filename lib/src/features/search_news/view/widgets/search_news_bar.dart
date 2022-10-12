import 'package:flutter/material.dart';

class SearchNewsBar extends StatelessWidget {
  final void Function(String)? onChanged;

  const SearchNewsBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
        hintText: 'Enter your query',
        filled: true,
        fillColor: const Color.fromARGB(255, 253, 241, 238),
      ),
      onChanged: onChanged,
    );
  }
}
