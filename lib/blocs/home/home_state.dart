part of 'home_bloc.dart';

enum HomeStatus { initial, submitting, sucsess, error ,medicineLoaded ,medicineLoading,medicineError}

class HomeState extends Equatable {
  final HomeStatus status;
  final MedicineResponse? medicineResponse;
  const HomeState({ this.status=HomeStatus.initial,this.medicineResponse});

  @override
  List<Object> get props => [ status];

  HomeState copyWith({
    HomeStatus? status,
    MedicineResponse? medicineResponse,
  }) {
    return HomeState(
      status: status ?? this.status,
      medicineResponse: medicineResponse ?? this.medicineResponse,
    );
  }
}
