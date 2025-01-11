part of 'all_fuel_types_bloc.dart';

sealed class AllFuelTypesEvent extends Equatable {
  const AllFuelTypesEvent();
}

final class LoadAllFuelTypesEvent extends AllFuelTypesEvent {
  @override
  List<Object?> get props => [];
}
