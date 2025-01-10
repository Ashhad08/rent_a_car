part of 'all_vehicles_bloc.dart';

sealed class AllVehiclesState extends Equatable {
  const AllVehiclesState();
}

final class AllVehiclesLoading extends AllVehiclesState {
  @override
  List<Object> get props => [];
}

final class AllVehiclesLoaded extends AllVehiclesState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const AllVehiclesLoaded({required List<VehicleModel> vehicles}) : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class AllVehiclesError extends AllVehiclesState {
  final String _error;

  String get error => _error;

  const AllVehiclesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
