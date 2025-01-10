import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/color_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'vehicle_all_colors_event.dart';
part 'vehicle_all_colors_state.dart';

class VehicleAllColorsBloc
    extends Bloc<VehicleAllColorsEvent, VehicleAllColorsState> {
  final MasterDataRepository _masterDataRepository;

  VehicleAllColorsBloc(this._masterDataRepository)
      : super(VehicleAllColorsLoading()) {
    on<LoadVehicleAllColorsEvent>(_onLoadVehicleAllColorsEvent);
  }

  Future<void> _onLoadVehicleAllColorsEvent(LoadVehicleAllColorsEvent event,
      Emitter<VehicleAllColorsState> emit) async {
    try {
      emit(VehicleAllColorsLoading());
      final response = await _masterDataRepository.getVehicleAllColors();
      emit(VehicleAllColorsLoaded(allColors: response));
    } catch (e) {
      emit(VehicleAllColorsError(error: e.toString()));
    }
  }
}
