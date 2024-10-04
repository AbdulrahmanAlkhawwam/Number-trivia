import 'package:flutter/material.dart';
import 'package:number_trivia/core/util/app_context.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LinearProgressIndicator(
          minHeight: context.height,
          color: context.colors.primary.withOpacity(0.75),
          backgroundColor: context.colors.primary.withOpacity(0.25),
          borderRadius: BorderRadius.circular(0.1),
        ),
      ),
    );
  }
}
