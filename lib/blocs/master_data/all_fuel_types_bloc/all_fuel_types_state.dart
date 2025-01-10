part of 'all_fuel_types_bloc.dart';

sealed class AllFuelTypesState extends Equatable {
  const AllFuelTypesState();
}

final class AllFuelTypesLoading extends AllFuelTypesState {
  @override
  List<Object> get props => [];
}

final class AllFuelTypesLoaded extends AllFuelTypesState {
  final List<FuelTypeModel> _fuelTypes;

  List<FuelTypeModel> get fuelTypes => _fuelTypes;

  const AllFuelTypesLoaded({required List<FuelTypeModel> fuelTypes})
      : _fuelTypes = fuelTypes;

  @override
  List<Object> get props => [_fuelTypes];
}

final class AllFuelTypesError extends AllFuelTypesState {
  final String _error;

  String get error => _error;

  const AllFuelTypesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
