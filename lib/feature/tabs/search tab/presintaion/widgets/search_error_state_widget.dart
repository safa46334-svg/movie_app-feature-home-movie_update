import 'package:flutter/material.dart';

class SearchErrorStateWidget extends StatelessWidget {
  final String message;
  const SearchErrorStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.redAccent)),
    );
  }
}
