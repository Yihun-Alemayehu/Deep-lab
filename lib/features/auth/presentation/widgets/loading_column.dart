import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  final String message;
  const LoadingColumn({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(message),
      ],
    );
  }
}