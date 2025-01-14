part of 'vehicle_all_makes_bloc.dart';

sealed class VehicleAllMakesState extends Equatable {
  const VehicleAllMakesState();
}

final class VehicleAllMakesLoading extends VehicleAllMakesState {
  @override
  List<Object> get props => [];
}

final class VehicleAllMakesLoaded extends VehicleAllMakesState {
  final List<VehicleMakeModel> _allMakes;

  List<VehicleMakeModel> get allMakes => _allMakes;

  const VehicleAllMakesLoaded({required List<VehicleMakeModel> allMakes})
      : _allMakes = allMakes;

  @override
  List<Object> get props => [_allMakes];
}

final class VehicleAllMakesError extends VehicleAllMakesState {
  final String _error;

  String get error => _error;

  const VehicleAllMakesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
