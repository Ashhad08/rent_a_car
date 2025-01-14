part of 'vehicle_models_bloc.dart';

sealed class VehicleModelsState extends Equatable {
  const VehicleModelsState();
}

final class VehicleModelsLoading extends VehicleModelsState {
  @override
  List<Object> get props => [];
}

final class VehicleModelsLoaded extends VehicleModelsState {
  final List<VehicleModelModel> _models;

  List<VehicleModelModel> get models => _models;

  const VehicleModelsLoaded({required List<VehicleModelModel> models})
      : _models = models;

  @override
  List<Object> get props => [_models];
}

final class VehicleModelsError extends VehicleModelsState {
  final String _error;

  String get error => _error;

  const VehicleModelsError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
