import '../../configurations/backend_configs.dart';
import '../../data/models/vehicle/vehicle.dart';
import '../../data/repositories/vehicle/vehicle_repository.dart';
import '../../network/network_repository.dart';

class VehicleApiRepository extends BaseVehicleRepository {
  final BackendConfigs _backendConfigs;
  final NetworkRepository _networkRepository;

  VehicleApiRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    try {
      final res = await _networkRepository.get(
          uri: _backendConfigs
              .buildUri(segments: [_backendConfigs.allVehicles]));
      return (res as Iterable)
          .map(
            (e) => Vehicle.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
