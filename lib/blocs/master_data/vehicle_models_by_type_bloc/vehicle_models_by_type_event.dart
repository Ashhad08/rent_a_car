part of 'vehicle_models_by_type_bloc.dart';

sealed class VehicleModelsByTypeEvent extends Equatable {
  const VehicleModelsByTypeEvent();
}

final class LoadVehicleModelsByTypeEvent extends VehicleModelsByTypeEvent {
  final String typeId;

  const LoadVehicleModelsByTypeEvent({required this.typeId});

  @override
  List<Object?> get props => [typeId];
}
