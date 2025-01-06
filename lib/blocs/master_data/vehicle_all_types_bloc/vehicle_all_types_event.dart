part of 'vehicle_all_types_bloc.dart';

sealed class VehicleAllTypesEvent extends Equatable {
  const VehicleAllTypesEvent();
}

final class LoadVehicleAllTypesEvent extends VehicleAllTypesEvent {
  @override
  List<Object?> get props => [];
}
