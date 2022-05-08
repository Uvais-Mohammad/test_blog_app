part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserResponse userResponse;
  const UserLoaded({required this.userResponse});
  @override
  List<Object> get props => [userResponse];
}


class UserError extends UserState {}