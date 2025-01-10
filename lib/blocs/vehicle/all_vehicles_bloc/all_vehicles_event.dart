part of 'all_vehicles_bloc.dart';

sealed class AllVehiclesEvent extends Equatable {
  const AllVehiclesEvent();
}

final class LoadAllVehiclesEvent extends AllVehiclesEvent {
  @override
  List<Object> get props => [];
}
