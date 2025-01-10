part of 'available_for_rent_vehicles_bloc.dart';

sealed class AvailableForRentVehiclesEvent extends Equatable {
  const AvailableForRentVehiclesEvent();
}

final class LoadAvailableForRentVehiclesEvent extends AvailableForRentVehiclesEvent {
  @override
  List<Object> get props => [];
}
