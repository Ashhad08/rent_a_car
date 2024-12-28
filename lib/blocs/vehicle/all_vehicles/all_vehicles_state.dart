part of 'all_vehicles_bloc.dart';

sealed class AllVehiclesState extends Equatable {
  const AllVehiclesState();
}

final class AllVehiclesLoading extends AllVehiclesState {
  @override
  List<Object> get props => [];
}

final class AllVehiclesLoaded extends AllVehiclesState {
  final List<Vehicle> _allVehicles;

  List<Vehicle> get allVehicles => _allVehicles;

  const AllVehiclesLoaded({required List<Vehicle> allVehicles})
      : _allVehicles = allVehicles;

  @override
  List<Object> get props => [
        _allVehicles,
      ];
}

final class AllVehiclesError extends AllVehiclesState {
  final String error;

  const AllVehiclesError({required this.error});

  @override
  List<Object> get props => [error];
}
