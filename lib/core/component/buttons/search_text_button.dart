import 'package:flutter/material.dart';

class SearchTextButton extends StatelessWidget {
  final Function() onPressed;

  const SearchTextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: const Text("search"),
    );
  }
}
