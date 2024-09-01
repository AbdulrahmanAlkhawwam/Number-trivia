import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/number_trivia.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaScreen extends StatelessWidget {
  final numberTrivia = NumberTrivia(
    text: "this is number trivia",
    number: 50,
  );

  NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: const Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Text(
                                "Start Searching !",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is Error) {
                      return Dialog(
                        child: Text(state.message),
                      );
                    } else if (state is Loading) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      children: [
                        Text(
                          numberTrivia.number.toString(),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(numberTrivia.text),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  children: <Widget>[
                    // holder
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        // holder
                        SizedBox(
                          width: 10,
                        )
                        // holder
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
