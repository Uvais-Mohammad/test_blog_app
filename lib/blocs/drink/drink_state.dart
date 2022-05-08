part of 'drink_bloc.dart';

abstract class DrinkState extends Equatable {
  const DrinkState();

  @override
  List<Object> get props => [];
}

class DrinkLoading extends DrinkState {}

class DrinkLoaded extends DrinkState {
  final DrinkResponse drinkResponse;
  const DrinkLoaded({required this.drinkResponse});
  @override
  List<Object> get props => [drinkResponse];
}

class DrinkError extends DrinkState {}