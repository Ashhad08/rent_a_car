part of 'vehicle_all_makes_bloc.dart';

sealed class VehicleAllMakesEvent extends Equatable {
  const VehicleAllMakesEvent();
}

final class LoadVehicleAllMakesEvent extends VehicleAllMakesEvent {
  @override
  List<Object?> get props => [];
}
