import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';

class NumberTriviaScreen extends StatelessWidget {
  NumberTriviaScreen({super.key});

  final globalKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  Widget? content;
  String inputStr = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NumberTriviaBloc>(
      create: (_) => sl<NumberTriviaBloc>(),
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          if (state is Error) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.8),
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
          return Scaffold(
            appBar: AppBar(
              title: const Text("Number Trivia"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    content ?? const SizedBox(),
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: globalKey,
                      child: TextFormField(
                        onFieldSubmitted: (value) => inputStr = value,
                        onChanged: (value) => inputStr = value,
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
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (globalKey.currentState?.validate() ?? false) {
                                BlocProvider.of<NumberTriviaBloc>(context)
                                    .add(GetTriviaForConcreteNumber(inputStr));
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
                                GetTriviaForRandomNumber(),
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
            /* body: BlocProvider(
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
      ),*/
          );
        },
      ),
    );
  }
}
