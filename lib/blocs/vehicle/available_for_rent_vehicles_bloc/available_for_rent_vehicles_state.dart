part of 'available_for_rent_vehicles_bloc.dart';

sealed class AvailableForRentVehiclesState extends Equatable {
  const AvailableForRentVehiclesState();
}

final class AvailableForRentVehiclesLoading extends AvailableForRentVehiclesState {
  @override
  List<Object> get props => [];
}

final class AvailableForRentVehiclesLoaded extends AvailableForRentVehiclesState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const AvailableForRentVehiclesLoaded({required List<VehicleModel> vehicles}) : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class AvailableForRentVehiclesError extends AvailableForRentVehiclesState {
  final String _error;

  String get error => _error;

  const AvailableForRentVehiclesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
