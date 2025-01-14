import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/vehicle_make_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_all_makes_event.dart';
part 'vehicle_all_makes_state.dart';

class VehicleAllMakesBloc
    extends Bloc<VehicleAllMakesEvent, VehicleAllMakesState> {
  final MasterDataRepository _masterDataRepository;

  VehicleAllMakesBloc(this._masterDataRepository)
      : super(VehicleAllMakesLoading()) {
    on<LoadVehicleAllMakesEvent>(_onLoadVehicleAllMakesEvent);
  }

  Future<void> _onLoadVehicleAllMakesEvent(LoadVehicleAllMakesEvent event,
      Emitter<VehicleAllMakesState> emit) async {
    try {
      emit(VehicleAllMakesLoading());
      final response = await _masterDataRepository.getVehicleAllMakes();
      emit(VehicleAllMakesLoaded(allMakes: response));
    } catch (e) {
      emit(VehicleAllMakesError(error: e.toString()));
    }
  }
}
