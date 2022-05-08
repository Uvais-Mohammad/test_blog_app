part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, sucsess, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final String email;
  final String password;
  const LoginState({
    required this.status,
    required this.email,
    required this.password,
  });

  factory LoginState.initial() =>
      const LoginState(status: LoginStatus.initial, email: '', password: '');
  @override
  List<Object> get props => [ status, email, password];

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
