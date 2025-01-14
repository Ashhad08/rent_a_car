part of 'vehicle_models_bloc.dart';

sealed class VehicleModelsEvent extends Equatable {
  const VehicleModelsEvent();
}

final class LoadVehicleModelsEvent extends VehicleModelsEvent {
  @override
  List<Object?> get props => [];
}
