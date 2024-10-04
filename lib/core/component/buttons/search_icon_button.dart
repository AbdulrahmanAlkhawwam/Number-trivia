import 'package:flutter/material.dart';
import 'package:number_trivia/core/util/app_context.dart';

class SearchIconButton extends StatelessWidget {
  final Function() onPressed;

  const SearchIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          context.colors.primary,
        ),
        foregroundColor: WidgetStatePropertyAll(
          context.colors.onPrimary,
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.search),
    );
  }
}
