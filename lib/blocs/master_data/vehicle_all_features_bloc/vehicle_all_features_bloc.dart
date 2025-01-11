import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/vehicle_feature_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_all_features_event.dart';
part 'vehicle_all_features_state.dart';

class VehicleAllFeaturesBloc
    extends Bloc<VehicleAllFeaturesEvent, VehicleAllFeaturesState> {
  final MasterDataRepository _masterDataRepository;

  VehicleAllFeaturesBloc(this._masterDataRepository)
      : super(VehicleAllFeaturesLoading()) {
    on<LoadVehicleAllFeaturesEvent>(_onLoadVehicleAllFeaturesEvent);
  }

  Future<void> _onLoadVehicleAllFeaturesEvent(LoadVehicleAllFeaturesEvent event,
      Emitter<VehicleAllFeaturesState> emit) async {
    try {
      emit(VehicleAllFeaturesLoading());
      final response = await _masterDataRepository.getVehicleAllFeatures();
      emit(VehicleAllFeaturesLoaded(allFeatures: response));
    } catch (e) {
      emit(VehicleAllFeaturesError(error: e.toString()));
    }
  }
}
