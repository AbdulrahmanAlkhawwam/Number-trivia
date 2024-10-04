import 'package:flutter/material.dart';
import 'package:number_trivia/core/component/buttons/search_icon_button.dart';
import 'package:number_trivia/core/component/buttons/search_text_button.dart';
import 'package:number_trivia/core/component/input_field.dart';
import 'package:number_trivia/core/util/app_context.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../widgets/text_widget.dart';

class LoadedScreen extends StatelessWidget {
  final NumberTrivia? numberTrivia;

  const LoadedScreen({
    super.key,
    this.numberTrivia,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: context.deviceMode == Orientation.portrait
            ? Text(
                "Number Trivia",
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colors.primary,
                ),
              )
            : Text(
                numberTrivia?.number.toString() ?? "NumberTrivia",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colors.primary,
                ),
              ),
        actions: context.deviceMode == Orientation.portrait
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    numberTrivia?.number.toString() ?? "",
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ]
            : [
                numberTrivia != null
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          "keyboard",
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colors.primary,
                          ),
                        ),
                      )
                    : const SizedBox(),
                SearchIconButton(
                  onPressed: () {},
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      context.colors.primaryFixedDim,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      context.colors.primary,
                    ),
                  ),
                  onPressed: () {
                    print("random");
                  },
                  icon: const Icon(Icons.shuffle),
                ),
              ],
      ),
      body: context.deviceMode == Orientation.portrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: TextWidget(
                      text: numberTrivia?.text ?? "Let's Start !",
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: InputField(
                            controller: controller,
                          ),
                        ),
                        const SizedBox(height: 10),
                        context.deviceMode == Orientation.portrait
                            ? Row(
                                children: [
                                  Expanded(
                                      child:
                                          SearchTextButton(onPressed: () {})),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: FilledButton.tonal(
                                      onPressed: () {},
                                      child: const Text("random"),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: TextWidget(
                      text: numberTrivia?.text ?? "Let's Start !",
                    ),
                  ),
                ),
                numberTrivia != null
                    ? const SizedBox()
                    : InputField(controller: controller)
              ],
            ),
    );
  }
}
