import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/master_data/color_model.dart';
import '../../models/master_data/fuel_type_model.dart';
import '../../models/master_data/vehicle_feature_model.dart';
import '../../models/master_data/vehicle_model_model.dart';
import '../../models/master_data/vehicle_type_model.dart';

abstract class BaseMasterDataRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseMasterDataRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  Future<List<ColorModel>> getVehicleAllColors();

  Future<List<VehicleFeatureModel>> getVehicleAllFeatures();

  Future<List<VehicleTypeModel>> getVehicleAllTypes();

  Future<List<FuelTypeModel>> getAllFuelTypes();

  Future<List<VehicleModelModel>> getVehicleModelsForVehicleType(
      {required String vehicleTypeId});

  Future<VehicleModelModel?> getVehicleModelModelById(
      {required String vehicleModelId});

  NetworkRepository get networkRepository => _networkRepository;
}
