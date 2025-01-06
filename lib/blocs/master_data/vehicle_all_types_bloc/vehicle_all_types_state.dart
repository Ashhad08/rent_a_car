part of 'vehicle_all_types_bloc.dart';

sealed class VehicleAllTypesState extends Equatable {
  const VehicleAllTypesState();
}

final class VehicleAllTypesLoading extends VehicleAllTypesState {
  @override
  List<Object> get props => [];
}

final class VehicleAllTypesLoaded extends VehicleAllTypesState {
  final List<VehicleTypeModel> _allTypes;

  List<VehicleTypeModel> get allTypes => _allTypes;

  const VehicleAllTypesLoaded({required List<VehicleTypeModel> allTypes})
      : _allTypes = allTypes;

  @override
  List<Object> get props => [_allTypes];
}

final class VehicleAllTypesError extends VehicleAllTypesState {
  final String _error;

  String get error => _error;

  const VehicleAllTypesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
