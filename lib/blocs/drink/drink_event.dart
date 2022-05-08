part of 'drink_bloc.dart';

abstract class DrinkEvent extends Equatable {
  const DrinkEvent();

  @override
  List<Object> get props => [];
}

class FetchDrinkEvent extends DrinkEvent {}