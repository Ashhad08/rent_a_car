part of 'vehicle_models_by_type_bloc.dart';

sealed class VehicleModelsByTypeState extends Equatable {
  const VehicleModelsByTypeState();
}

final class VehicleModelsByTypeLoading extends VehicleModelsByTypeState {
  @override
  List<Object> get props => [];
}

final class VehicleModelsByTypeLoaded extends VehicleModelsByTypeState {
  final List<VehicleModelModel> _modelsByType;

  List<VehicleModelModel> get modelsByType => _modelsByType;

  const VehicleModelsByTypeLoaded(
      {required List<VehicleModelModel> modelsByType})
      : _modelsByType = modelsByType;

  @override
  List<Object> get props => [_modelsByType];
}

final class VehicleModelsByTypeError extends VehicleModelsByTypeState {
  final String _error;

  String get error => _error;

  const VehicleModelsByTypeError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
