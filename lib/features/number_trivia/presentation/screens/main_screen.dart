import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:number_trivia/core/util/app_context.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/screens/content_screen.dart';
import 'package:number_trivia/features/number_trivia/presentation/screens/loading_screen.dart';

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
          switch (state) {
            case Loading _:
              return const LoadingScreen();
            case Loaded _:
              return LoadedScreen(
                numberTrivia: state.trivia,
              );
            case Empty _:
              return const LoadedScreen();
            case Error _:
              return Container(color: Colors.red);
          }

          print("hello world ");
          return Scaffold(
            body: Container(
              color: Colors.red,
            ),
          );
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
                    Form(key: globalKey, child: Container()),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (/*globalKey.currentState?.validate() ?? */ false) {
                                globalKey.currentState?.save();
                                BlocProvider.of<NumberTriviaBloc>(context).add(
                                  ConcreteNumberEvent(
                                    controller.text,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                context.showErrorSnackBar(
                                    massage:
                                        "you should use RANDOM button when you don't want to add number !");
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
