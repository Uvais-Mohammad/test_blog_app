import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_demo/models/user_response.dart';
import 'package:new_demo/repositories/data_repository.dart';
import 'package:new_demo/services/preference.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DataRepository dataRepository = DataRepository();

  UserBloc() : super(UserLoading()) {
    on<FetchUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final data = await dataRepository.getData();
        emit(UserLoaded(userResponse: data));
      }on SocketException catch (_) {
        var dataFromLocal=Preference.getString('user');
        var data = UserResponse.fromJson(jsonDecode(dataFromLocal!));
         emit(UserLoaded(userResponse: data));
      }
      on Exception catch (_) {
        emit(UserError());
      }
    });
  }
}
