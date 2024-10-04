import 'package:flutter/material.dart';
import 'package:number_trivia/core/util/app_context.dart';

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.primary,
        ),
      ),
    );
  }
}
