import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_demo/models/drink_response.dart';
import 'package:new_demo/repositories/data_repository.dart';
import 'package:new_demo/services/preference.dart';

part 'drink_event.dart';
part 'drink_state.dart';

class DrinkBloc extends Bloc<DrinkEvent, DrinkState> {
  DrinkBloc() : super(DrinkLoading()) {
    final DataRepository dataRepository = DataRepository();
    on<FetchDrinkEvent>((event, emit) async {
      emit(DrinkLoading());
      try {
        final data = await dataRepository.getDrink();
        emit(DrinkLoaded(drinkResponse: data));
      } on SocketException catch (_) {
        var dataFromLocal = Preference.getString('drink');
        var data = DrinkResponse.fromJson(jsonDecode(dataFromLocal!));
        emit(DrinkLoaded(drinkResponse: data));
      } on Exception catch (_) {
        emit(DrinkError());
      }
    });
  }
}
