import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_demo/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository = AuthRepository();
  LoginCubit() : super(LoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void loginPressed() async {
    if (state.status == LoginStatus.submitting) {
      return;
    }

    emit(state.copyWith(status: LoginStatus.submitting));
    bool login = await authRepository.login(state.email, state.password);
    if (login) {
      emit(state.copyWith(status: LoginStatus.sucsess));
    } else {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
