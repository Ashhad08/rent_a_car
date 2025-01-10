import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/fuel_type_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'all_fuel_types_event.dart';
part 'all_fuel_types_state.dart';

class AllFuelTypesBloc extends Bloc<AllFuelTypesEvent, AllFuelTypesState> {
  final MasterDataRepository _masterDataRepository;

  AllFuelTypesBloc(this._masterDataRepository) : super(AllFuelTypesLoading()) {
    on<LoadAllFuelTypesEvent>(_onLoadAllFuelTypesEvent);
  }

  Future<void> _onLoadAllFuelTypesEvent(
      LoadAllFuelTypesEvent event, Emitter<AllFuelTypesState> emit) async {
    try {
      emit(AllFuelTypesLoading());
      final response = await _masterDataRepository.getAllFuelTypes();
      emit(AllFuelTypesLoaded(fuelTypes: response));
    } catch (e) {
      emit(AllFuelTypesError(error: e.toString()));
    }
  }
}
