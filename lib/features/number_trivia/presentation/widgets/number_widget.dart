import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? content;
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
      if (state is Error) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error.withOpacity(0.8),
                  size: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "There are some error \n reOpen the app !",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                )
              ],
            ),
          ),
        );
      } else if (state is Loading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is Empty) {
        content = Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              "Start Searching !",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      } else if (state is Loaded) {
        content = Column(
          children: [
            Text(
              state.trivia.number.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Text(
                  state.trivia.text.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return content!;
    });
  }
}
