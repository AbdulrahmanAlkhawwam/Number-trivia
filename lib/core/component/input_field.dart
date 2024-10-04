import 'package:flutter/material.dart';
import 'package:number_trivia/core/util/app_context.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          context.deviceMode == Orientation.landscape ? 450 : double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) => value == null ||
                value.isEmpty ||
                double.tryParse(value) == null ||
                double.parse(value) <= 0
            ? "You must add positive number"
            : null,
        decoration: InputDecoration(
          hintText: "Enter number",
          helperStyle: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: context.colors.outlineVariant.withOpacity(0.25),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 2.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.errorContainer,
              width: 2.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
