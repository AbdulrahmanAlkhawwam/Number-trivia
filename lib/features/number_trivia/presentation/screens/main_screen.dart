import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/number_widget.dart';
import '../bloc/number_trivia_bloc.dart';
import '../../../../injection_container.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    return BlocProvider<NumberTriviaBloc>(
      create: (_) => sl<NumberTriviaBloc>(),
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Number Trivia"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const NumberWidget(),
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: globalKey,
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty
                            ? "You must add positive number"
                            : null,
                        decoration: InputDecoration(
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
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              width: 2.5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
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
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (globalKey.currentState?.validate() ?? false) {
                                globalKey.currentState?.save();
                                BlocProvider.of<NumberTriviaBloc>(context).add(
                                  ConcreteNumberEvent(
                                    controller.text,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "you should use RANDOM button when you don't want to add number !"),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "search".toUpperCase(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              BlocProvider.of<NumberTriviaBloc>(context).add(
                                RandomNumberEvent(),
                              );
                            },
                            child: Text(
                              "random".toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
