import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_demo/models/medicine_response.dart';
import 'package:new_demo/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository = HomeRepository();
  HomeBloc() : super(const HomeState(status: HomeStatus.initial)) {
    on<FetchMedicine>((event, emit) async {
      emit(const HomeState(status: HomeStatus.medicineLoading));
      try {
        final response = await homeRepository.getMedicine();
        emit(const HomeState().copyWith(
            status: HomeStatus.medicineLoaded, medicineResponse: response));
      } catch (_) {
        print(_);
        emit(const HomeState().copyWith(status: HomeStatus.medicineError));
      }
    });
  }
}
