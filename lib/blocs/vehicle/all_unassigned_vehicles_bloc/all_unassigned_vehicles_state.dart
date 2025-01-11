part of 'all_unassigned_vehicles_bloc.dart';

sealed class AllUnassignedVehiclesState extends Equatable {
  const AllUnassignedVehiclesState();
}

final class AllUnassignedVehiclesLoading extends AllUnassignedVehiclesState {
  @override
  List<Object> get props => [];
}

final class AllUnassignedVehiclesLoaded extends AllUnassignedVehiclesState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const AllUnassignedVehiclesLoaded({required List<VehicleModel> vehicles})
      : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class AllUnassignedVehiclesError extends AllUnassignedVehiclesState {
  final String _error;

  String get error => _error;

  const AllUnassignedVehiclesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
