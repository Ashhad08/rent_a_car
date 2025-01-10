import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/vehicle_type_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_all_types_event.dart';
part 'vehicle_all_types_state.dart';

class VehicleAllTypesBloc
    extends Bloc<VehicleAllTypesEvent, VehicleAllTypesState> {
  final MasterDataRepository _masterDataRepository;

  VehicleAllTypesBloc(this._masterDataRepository)
      : super(VehicleAllTypesLoading()) {
    on<LoadVehicleAllTypesEvent>(_onLoadVehicleAllTypesEvent);
  }

  Future<void> _onLoadVehicleAllTypesEvent(LoadVehicleAllTypesEvent event,
      Emitter<VehicleAllTypesState> emit) async {
    try {
      emit(VehicleAllTypesLoading());
      final response = await _masterDataRepository.getVehicleAllTypes();
      emit(VehicleAllTypesLoaded(allTypes: response));
    } catch (e) {
      emit(VehicleAllTypesError(error: e.toString()));
    }
  }
}
