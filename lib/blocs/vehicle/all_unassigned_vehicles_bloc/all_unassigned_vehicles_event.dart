part of 'all_unassigned_vehicles_bloc.dart';

sealed class AllUnassignedVehiclesEvent extends Equatable {
  const AllUnassignedVehiclesEvent();
}

final class LoadAllUnassignedVehiclesEvent extends AllUnassignedVehiclesEvent {
  @override
  List<Object> get props => [];
}
