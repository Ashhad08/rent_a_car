part of 'vehicle_all_features_bloc.dart';

sealed class VehicleAllFeaturesEvent extends Equatable {
  const VehicleAllFeaturesEvent();
}

final class LoadVehicleAllFeaturesEvent extends VehicleAllFeaturesEvent {
  @override
  List<Object?> get props => [];
}
