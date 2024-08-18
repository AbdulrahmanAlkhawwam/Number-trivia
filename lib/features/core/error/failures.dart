import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.properties});

  final properties ;

  @override
  List<Object?> get props => properties;
}