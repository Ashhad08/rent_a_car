part of 'vehicle_all_colors_bloc.dart';

sealed class VehicleAllColorsEvent extends Equatable {
  const VehicleAllColorsEvent();
}

final class LoadVehicleAllColorsEvent extends VehicleAllColorsEvent {
  @override
  List<Object?> get props => [];
}
