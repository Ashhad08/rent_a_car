import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_models_by_type_event.dart';
part 'vehicle_models_by_type_state.dart';

class VehicleModelsByTypeBloc
    extends Bloc<VehicleModelsByTypeEvent, VehicleModelsByTypeState> {
  final MasterDataRepository _masterDataRepository;

  VehicleModelsByTypeBloc(this._masterDataRepository)
      : super(VehicleModelsByTypeLoading()) {
    on<LoadVehicleModelsByTypeEvent>(_onLoadVehicleModelsByTypeEvent);
  }

  Future<void> _onLoadVehicleModelsByTypeEvent(
      LoadVehicleModelsByTypeEvent event,
      Emitter<VehicleModelsByTypeState> emit) async {
    try {
      emit(VehicleModelsByTypeLoading());
      final response = await _masterDataRepository
          .getVehicleModelsForVehicleType(vehicleTypeId: event.typeId);
      emit(VehicleModelsByTypeLoaded(modelsByType: response));
    } catch (e) {
      emit(VehicleModelsByTypeError(error: e.toString()));
    }
  }
}
